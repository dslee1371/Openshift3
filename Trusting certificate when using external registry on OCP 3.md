# Trusting certificate when using external registry on OCP 3
## Evironments
- Red Hat Openshift Container Plaform 3.11

## Issue
The image builds would not work using images on the internal cluster registry(docker-registry-default.domain.com) that were utilizing the image pullthroush feature from adnother external registry (external.artifactory.doamin.com) with custom TLS CA trust chain.

## Solution
Trust the certificate inside the Registry pod, as indicates documentation : Middleware - Repository - Pullthrough https://docs.openshift.com/container-platform/3.11/install_config/registry/extended_registry_configuration.html?extIdCarryOver=true&sc_cid=701f2000001Css5AAC#middleware-repository-pullthrough
- Make a copy of `tls-ca-bundle.pem` (with the CAs installed) from
`master.example.com:/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem`
  - Importantly, this .pem should have all the trusted CAs from RHEL, and the ones from the company. Use a file like that from a host that already has internal CAs installed and `# update-ca-trust` ran for best results. Check solution: Build process cannot pull image from the external registry which has a custom certificate.
https://access.redhat.com/solutions/3759211

- Create a secret in the `default` namespace frim that file
```
$ oc create secret generic new-tls-ca-bundle --from-file=tls-ca-bundle.pem -n default
```

- Link the secret to the registry and default service account. Steps at documentation, session: Securing the registry https://docs.openshift.com/container-platform/3.11/install_config/registry/securing_and_exposing_registry.html?extIdCarryOver=true&sc_cid=701f2000001Css5AAC#securing-the-registry
```
$ oc secrets link registry new-tls-ca-bundle
$ oc secrets link default new-tls-ca-bundle
```

- Add the secret as a volume to the Registry deployment config.
```
$ oc set volume dc/docker-registry --add --type=secret \
>      --secret-name=new-tls-ca-bundle -m /etc/pki/tls/certs

## Cause
The internal OpenShift registry pod is not aware of the trusted CAs, and when trying to use passthrough images via builds, the Registry pod rejected connections to the external registry with custom/internal TLS CA chain.

Product(s) `Red Hat Openshift Container Platform`           Categories `Configure`                  Configure list `certificates`
Tags  `certificates` `certificate_authority`  `openshift`      `tls`

This solution is part of Red Hats fast-track publication program, providing a huge library of solutions that Red Hat engineers have created while supporting our customers. To give you the knowledge you need the instant it becomes available, these articles may be presented in a raw and unedited form.

https://access.redhat.com/solutions/3759211
