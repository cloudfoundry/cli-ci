#!/usr/bin/env bash

# This script creates a deployment using toolsmith

smith claim -p cf-deployment -n "pipeline pools" | sed -n '2 p'

# smith cf-login

