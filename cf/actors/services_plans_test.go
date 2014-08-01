package actors_test

import (
	"errors"

	"github.com/cloudfoundry/cli/cf/actors"
	"github.com/cloudfoundry/cli/cf/api/fakes"
	"github.com/cloudfoundry/cli/cf/models"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("Service Plans", func() {
	var (
		actor                     actors.ServicePlanActor
		serviceRepo               *fakes.FakeServiceRepo
		servicePlanRepo           *fakes.FakeServicePlanRepo
		servicePlanVisibilityRepo *fakes.FakeServicePlanVisibilityRepository
		orgRepo                   *fakes.FakeOrgRepository

		privateServicePlanVisibilityFields models.ServicePlanVisibilityFields

		publicServicePlan  models.ServicePlanFields
		privateServicePlan models.ServicePlanFields

		mixedService models.ServiceOffering
	)

	BeforeEach(func() {
		serviceRepo = &fakes.FakeServiceRepo{}
		servicePlanRepo = &fakes.FakeServicePlanRepo{}
		servicePlanVisibilityRepo = &fakes.FakeServicePlanVisibilityRepository{}
		orgRepo = &fakes.FakeOrgRepository{}

		actor = actors.NewServicePlanHandler(serviceRepo, servicePlanRepo, servicePlanVisibilityRepo, orgRepo)

		privateServicePlanVisibilityFields = models.ServicePlanVisibilityFields{
			Guid:            "private-service-plan-visibility-guid",
			ServicePlanGuid: "private-service-plan-guid",
		}

		publicServicePlan = models.ServicePlanFields{
			Name:   "public-service-plan",
			Guid:   "public-service-plan-guid",
			Public: true,
		}

		privateServicePlan = models.ServicePlanFields{
			Name:   "private-service-plan",
			Guid:   "private-service-plan-guid",
			Public: false,
			OrgNames: []string{
				"org-1",
				"org-2",
			},
		}

		mixedService = models.ServiceOffering{
			ServiceOfferingFields: models.ServiceOfferingFields{
				Label: "my-mixed-service",
				Guid:  "my-mixed-service-guid",
			},
			Plans: []models.ServicePlanFields{
				publicServicePlan,
				privateServicePlan,
			},
		}
	})

	Describe(".UpdateSinglePlanForService", func() {
		BeforeEach(func() {
			serviceRepo.FindServiceOfferingByLabelServiceOffering = mixedService

			servicePlanVisibilityRepo.ListReturns(
				[]models.ServicePlanVisibilityFields{privateServicePlanVisibilityFields}, nil)

			servicePlanRepo.SearchReturns = map[string][]models.ServicePlanFields{
				"my-mixed-service-guid": {
					publicServicePlan,
					privateServicePlan,
				},
			}
		})

		It("Returns an error if the service cannot be found", func() {
			serviceRepo.FindServiceOfferingByLabelApiResponse = errors.New("service was not found")

			_, err := actor.UpdateSinglePlanForService("not-a-service", "public-service-plan")
			Expect(err.Error()).To(Equal("service was not found"))
		})

		It("Returns an error if the plan cannot be found", func() {
			_, err := actor.UpdateSinglePlanForService("my-mixed-service", "not-a-service-plan")
			Expect(err.Error()).To(Equal("The plan not-a-service-plan could not be found for service my-mixed-service"))
		})

		It("Returns true if the original plan was public", func() {
			serviceOriginallyPublic, err := actor.UpdateSinglePlanForService("my-mixed-service", "public-service-plan")
			Expect(err).NotTo(HaveOccurred())
			Expect(serviceOriginallyPublic).To(BeTrue())
		})

		It("Does not try to update the service plan if it is already public", func() {
			_, err := actor.UpdateSinglePlanForService("my-mixed-service", "public-service-plan")
			Expect(err).ToNot(HaveOccurred())

			Expect(servicePlanRepo.UpdateCallCount()).To(Equal(0))
		})

		It("Returns false if the original plan was private", func() {
			serviceOriginallyPublic, err := actor.UpdateSinglePlanForService("my-mixed-service", "private-service-plan")
			Expect(err).NotTo(HaveOccurred())
			Expect(serviceOriginallyPublic).To(BeFalse())
		})

		It("removes the service plan visibilities for the service plan", func() {
			_, err := actor.UpdateSinglePlanForService("my-mixed-service", "private-service-plan")
			Expect(err).ToNot(HaveOccurred())

			servicePlanVisibilityGuid := servicePlanVisibilityRepo.DeleteArgsForCall(0)
			Expect(servicePlanVisibilityGuid).To(Equal("private-service-plan-visibility-guid"))
		})

		It("sets a service plan to public", func() {
			_, err := actor.UpdateSinglePlanForService("my-mixed-service", "private-service-plan")
			Expect(err).ToNot(HaveOccurred())

			servicePlan, serviceGuid, public := servicePlanRepo.UpdateArgsForCall(0)
			Expect(servicePlan.Public).To(BeFalse())
			Expect(serviceGuid).To(Equal("my-mixed-service-guid"))
			Expect(public).To(BeTrue())
		})
	})
})
