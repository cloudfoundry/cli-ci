// Code generated by counterfeiter. DO NOT EDIT.
package v2actionfakes

import (
	"sync"

	"code.cloudfoundry.org/cli/actor/v2action"
	"code.cloudfoundry.org/cli/api/uaa"
	"code.cloudfoundry.org/cli/api/uaa/constant"
)

type FakeUAAClient struct {
	AuthenticateStub        func(ID string, secret string, origin string, grantType constant.GrantType) (string, string, error)
	authenticateMutex       sync.RWMutex
	authenticateArgsForCall []struct {
		ID        string
		secret    string
		grantType constant.GrantType
	}
	authenticateReturns struct {
		result1 string
		result2 string
		result3 error
	}
	authenticateReturnsOnCall map[int]struct {
		result1 string
		result2 string
		result3 error
	}
	CreateUserStub        func(username string, password string, origin string) (uaa.User, error)
	createUserMutex       sync.RWMutex
	createUserArgsForCall []struct {
		username string
		password string
		origin   string
	}
	createUserReturns struct {
		result1 uaa.User
		result2 error
	}
	createUserReturnsOnCall map[int]struct {
		result1 uaa.User
		result2 error
	}
	GetSSHPasscodeStub        func(accessToken string, sshOAuthClient string) (string, error)
	getSSHPasscodeMutex       sync.RWMutex
	getSSHPasscodeArgsForCall []struct {
		accessToken    string
		sshOAuthClient string
	}
	getSSHPasscodeReturns struct {
		result1 string
		result2 error
	}
	getSSHPasscodeReturnsOnCall map[int]struct {
		result1 string
		result2 error
	}
	RefreshAccessTokenStub        func(refreshToken string) (uaa.RefreshedTokens, error)
	refreshAccessTokenMutex       sync.RWMutex
	refreshAccessTokenArgsForCall []struct {
		refreshToken string
	}
	refreshAccessTokenReturns struct {
		result1 uaa.RefreshedTokens
		result2 error
	}
	refreshAccessTokenReturnsOnCall map[int]struct {
		result1 uaa.RefreshedTokens
		result2 error
	}
	invocations      map[string][][]interface{}
	invocationsMutex sync.RWMutex
}

func (fake *FakeUAAClient) Authenticate(ID string, secret string, origin string, grantType constant.GrantType) (string, string, error) {
	fake.authenticateMutex.Lock()
	ret, specificReturn := fake.authenticateReturnsOnCall[len(fake.authenticateArgsForCall)]
	fake.authenticateArgsForCall = append(fake.authenticateArgsForCall, struct {
		ID        string
		secret    string
		grantType constant.GrantType
	}{ID, secret, grantType})
	fake.recordInvocation("Authenticate", []interface{}{ID, secret, grantType})
	fake.authenticateMutex.Unlock()
	if fake.AuthenticateStub != nil {
		return fake.AuthenticateStub(ID, secret, "", grantType)
	}
	if specificReturn {
		return ret.result1, ret.result2, ret.result3
	}
	return fake.authenticateReturns.result1, fake.authenticateReturns.result2, fake.authenticateReturns.result3
}

func (fake *FakeUAAClient) AuthenticateCallCount() int {
	fake.authenticateMutex.RLock()
	defer fake.authenticateMutex.RUnlock()
	return len(fake.authenticateArgsForCall)
}

func (fake *FakeUAAClient) AuthenticateArgsForCall(i int) (string, string, constant.GrantType) {
	fake.authenticateMutex.RLock()
	defer fake.authenticateMutex.RUnlock()
	return fake.authenticateArgsForCall[i].ID, fake.authenticateArgsForCall[i].secret, fake.authenticateArgsForCall[i].grantType
}

func (fake *FakeUAAClient) AuthenticateReturns(result1 string, result2 string, result3 error) {
	fake.AuthenticateStub = nil
	fake.authenticateReturns = struct {
		result1 string
		result2 string
		result3 error
	}{result1, result2, result3}
}

func (fake *FakeUAAClient) AuthenticateReturnsOnCall(i int, result1 string, result2 string, result3 error) {
	fake.AuthenticateStub = nil
	if fake.authenticateReturnsOnCall == nil {
		fake.authenticateReturnsOnCall = make(map[int]struct {
			result1 string
			result2 string
			result3 error
		})
	}
	fake.authenticateReturnsOnCall[i] = struct {
		result1 string
		result2 string
		result3 error
	}{result1, result2, result3}
}

func (fake *FakeUAAClient) CreateUser(username string, password string, origin string) (uaa.User, error) {
	fake.createUserMutex.Lock()
	ret, specificReturn := fake.createUserReturnsOnCall[len(fake.createUserArgsForCall)]
	fake.createUserArgsForCall = append(fake.createUserArgsForCall, struct {
		username string
		password string
		origin   string
	}{username, password, origin})
	fake.recordInvocation("CreateUser", []interface{}{username, password, origin})
	fake.createUserMutex.Unlock()
	if fake.CreateUserStub != nil {
		return fake.CreateUserStub(username, password, origin)
	}
	if specificReturn {
		return ret.result1, ret.result2
	}
	return fake.createUserReturns.result1, fake.createUserReturns.result2
}

func (fake *FakeUAAClient) CreateUserCallCount() int {
	fake.createUserMutex.RLock()
	defer fake.createUserMutex.RUnlock()
	return len(fake.createUserArgsForCall)
}

func (fake *FakeUAAClient) CreateUserArgsForCall(i int) (string, string, string) {
	fake.createUserMutex.RLock()
	defer fake.createUserMutex.RUnlock()
	return fake.createUserArgsForCall[i].username, fake.createUserArgsForCall[i].password, fake.createUserArgsForCall[i].origin
}

func (fake *FakeUAAClient) CreateUserReturns(result1 uaa.User, result2 error) {
	fake.CreateUserStub = nil
	fake.createUserReturns = struct {
		result1 uaa.User
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) CreateUserReturnsOnCall(i int, result1 uaa.User, result2 error) {
	fake.CreateUserStub = nil
	if fake.createUserReturnsOnCall == nil {
		fake.createUserReturnsOnCall = make(map[int]struct {
			result1 uaa.User
			result2 error
		})
	}
	fake.createUserReturnsOnCall[i] = struct {
		result1 uaa.User
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) GetSSHPasscode(accessToken string, sshOAuthClient string) (string, error) {
	fake.getSSHPasscodeMutex.Lock()
	ret, specificReturn := fake.getSSHPasscodeReturnsOnCall[len(fake.getSSHPasscodeArgsForCall)]
	fake.getSSHPasscodeArgsForCall = append(fake.getSSHPasscodeArgsForCall, struct {
		accessToken    string
		sshOAuthClient string
	}{accessToken, sshOAuthClient})
	fake.recordInvocation("GetSSHPasscode", []interface{}{accessToken, sshOAuthClient})
	fake.getSSHPasscodeMutex.Unlock()
	if fake.GetSSHPasscodeStub != nil {
		return fake.GetSSHPasscodeStub(accessToken, sshOAuthClient)
	}
	if specificReturn {
		return ret.result1, ret.result2
	}
	return fake.getSSHPasscodeReturns.result1, fake.getSSHPasscodeReturns.result2
}

func (fake *FakeUAAClient) GetSSHPasscodeCallCount() int {
	fake.getSSHPasscodeMutex.RLock()
	defer fake.getSSHPasscodeMutex.RUnlock()
	return len(fake.getSSHPasscodeArgsForCall)
}

func (fake *FakeUAAClient) GetSSHPasscodeArgsForCall(i int) (string, string) {
	fake.getSSHPasscodeMutex.RLock()
	defer fake.getSSHPasscodeMutex.RUnlock()
	return fake.getSSHPasscodeArgsForCall[i].accessToken, fake.getSSHPasscodeArgsForCall[i].sshOAuthClient
}

func (fake *FakeUAAClient) GetSSHPasscodeReturns(result1 string, result2 error) {
	fake.GetSSHPasscodeStub = nil
	fake.getSSHPasscodeReturns = struct {
		result1 string
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) GetSSHPasscodeReturnsOnCall(i int, result1 string, result2 error) {
	fake.GetSSHPasscodeStub = nil
	if fake.getSSHPasscodeReturnsOnCall == nil {
		fake.getSSHPasscodeReturnsOnCall = make(map[int]struct {
			result1 string
			result2 error
		})
	}
	fake.getSSHPasscodeReturnsOnCall[i] = struct {
		result1 string
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) RefreshAccessToken(refreshToken string) (uaa.RefreshedTokens, error) {
	fake.refreshAccessTokenMutex.Lock()
	ret, specificReturn := fake.refreshAccessTokenReturnsOnCall[len(fake.refreshAccessTokenArgsForCall)]
	fake.refreshAccessTokenArgsForCall = append(fake.refreshAccessTokenArgsForCall, struct {
		refreshToken string
	}{refreshToken})
	fake.recordInvocation("RefreshAccessToken", []interface{}{refreshToken})
	fake.refreshAccessTokenMutex.Unlock()
	if fake.RefreshAccessTokenStub != nil {
		return fake.RefreshAccessTokenStub(refreshToken)
	}
	if specificReturn {
		return ret.result1, ret.result2
	}
	return fake.refreshAccessTokenReturns.result1, fake.refreshAccessTokenReturns.result2
}

func (fake *FakeUAAClient) RefreshAccessTokenCallCount() int {
	fake.refreshAccessTokenMutex.RLock()
	defer fake.refreshAccessTokenMutex.RUnlock()
	return len(fake.refreshAccessTokenArgsForCall)
}

func (fake *FakeUAAClient) RefreshAccessTokenArgsForCall(i int) string {
	fake.refreshAccessTokenMutex.RLock()
	defer fake.refreshAccessTokenMutex.RUnlock()
	return fake.refreshAccessTokenArgsForCall[i].refreshToken
}

func (fake *FakeUAAClient) RefreshAccessTokenReturns(result1 uaa.RefreshedTokens, result2 error) {
	fake.RefreshAccessTokenStub = nil
	fake.refreshAccessTokenReturns = struct {
		result1 uaa.RefreshedTokens
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) RefreshAccessTokenReturnsOnCall(i int, result1 uaa.RefreshedTokens, result2 error) {
	fake.RefreshAccessTokenStub = nil
	if fake.refreshAccessTokenReturnsOnCall == nil {
		fake.refreshAccessTokenReturnsOnCall = make(map[int]struct {
			result1 uaa.RefreshedTokens
			result2 error
		})
	}
	fake.refreshAccessTokenReturnsOnCall[i] = struct {
		result1 uaa.RefreshedTokens
		result2 error
	}{result1, result2}
}

func (fake *FakeUAAClient) Invocations() map[string][][]interface{} {
	fake.invocationsMutex.RLock()
	defer fake.invocationsMutex.RUnlock()
	fake.authenticateMutex.RLock()
	defer fake.authenticateMutex.RUnlock()
	fake.createUserMutex.RLock()
	defer fake.createUserMutex.RUnlock()
	fake.getSSHPasscodeMutex.RLock()
	defer fake.getSSHPasscodeMutex.RUnlock()
	fake.refreshAccessTokenMutex.RLock()
	defer fake.refreshAccessTokenMutex.RUnlock()
	copiedInvocations := map[string][][]interface{}{}
	for key, value := range fake.invocations {
		copiedInvocations[key] = value
	}
	return copiedInvocations
}

func (fake *FakeUAAClient) recordInvocation(key string, args []interface{}) {
	fake.invocationsMutex.Lock()
	defer fake.invocationsMutex.Unlock()
	if fake.invocations == nil {
		fake.invocations = map[string][][]interface{}{}
	}
	if fake.invocations[key] == nil {
		fake.invocations[key] = [][]interface{}{}
	}
	fake.invocations[key] = append(fake.invocations[key], args)
}

var _ v2action.UAAClient = new(FakeUAAClient)
