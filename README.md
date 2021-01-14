# Akka Platform Operator Charts

This repository contains Helm charts for the [Akka Platform](https://developer.lightbend.com/docs/akka-platform-guide/).

## Usage

Add this repository using the following commands:

```
helm repo add akka-operator-helm https://lightbend.github.io/akka-operator-helm/ 
helm repo update
```

Install the operator (requires commercial license):
```
helm install akka-operator
```
