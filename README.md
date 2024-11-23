# adhar-control-plane

> The API server for managing Adhar control plane.

## Overview

The `adhar-control-plane` project provides a comprehensive API server for managing control plane resources. It leverages Upbound's Crossplane to manage cloud infrastructure and services declaratively. This README provides instructions for setting up, running, and managing your control plane using the `up` CLI tool.

## Prerequisites

Before getting started, ensure you have the following prerequisites installed:

- [Up CLI](https://upbound.io/docs/up/install/) (v0.4.0 or later)
- [Docker](https://www.docker.com/get-started) (for running local development environments)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (for interacting with your Kubernetes cluster)
- [kcl-cli](https://kcl-lang.io/docs/user_docs/getting-started/install) (for running KCL scripts)
- [kcl language server](https://kcl-lang.io/docs/user_docs/getting-started/install) (for KCL language support in your IDE)


## Getting Started

### Add Dependencies (Provider/Configuration/Function)

Add the necessary dependencies to your project using the `up` CLI:

```bash
# Provider
up dependency add xpkg.upbound.io/upbound/provider-aws-s3:v1.16.0

# Configuration
up dependency add xpkg.upbound.io/upbound/platform-ref-aws:v1.2.0

# Function
up dependency add xpkg.upbound.io/crossplane-contrib/function-status-transformer:v0.4.0
```

### Generate an example claim
```bash
up example generate
```

### Generate the XRD
```bash
up xrd generate examples/bucket/example.yaml
```

### Generate a project function
```bash
up function generate xcluster
```

### Scaffold the composition from the XRD
```bash
up composition generate apis/xbuckets/definition.yaml
```

### Generate an embedded function for composition
```bash
up function generate --language=kcl test-function apis/xbuckets/composition.yaml
```

### login to Upbound
```bash
up login
```

### Select Upbound context
```bash
up ctx
```

### Running and testing your Control Plane Projects
```bash
up project run
```

### Build your configuration deployment
```bash
up project build
```

### Push your configuration
```bash
up project push
```

### Update dependencies
```bash
up dependency update-cache
```

### Clean dependencies
```bash
up dependency clean-cache
```

