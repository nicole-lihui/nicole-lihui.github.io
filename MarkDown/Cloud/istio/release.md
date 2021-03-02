## 1.3
* simplified the configuration model for Mixer and removed support for adapter-specific and template-specific Custom Resource Definitions (CRDs) entirely
* Trust domain validation
* Secret discovery service: only supports trustworthy JWTs and requires the audience, the value of the aud field, to be istio-ca when you enable SDS.



