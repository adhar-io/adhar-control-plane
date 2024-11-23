
import models.io.adhar.platform.v1alpha1 as platformv1alpha1
import models.io.upbound.aws.v1alpha1 as awsv1alpha1
import models.io.upbound.aws.v1beta1 as awsv1beta1
import models.k8s.apimachinery.pkg.apis.meta.v1 as metav1

oxr = option("params").oxr # observed composite resource
_ocds = option("params").ocds # observed composed resources
_dxr = option("params").dxr # desired composite resource
dcds = option("params").dcds # desired composed resources

_metadata = lambda name: str -> any {
    { annotations = { "krm.kcl.dev/composition-resource-name" = name }}
}

# Example to retrieve variables from "xr"; update as needed
# _region = "us-east-1"
# if oxr.spec?.parameters?.region:
#     _region = oxr.spec.parameters.region

_items = [
  v1beta1.Bucket{
    metadata.name = oxr.metadata.name
    spec.forProvider: {
      objectLockEnabled = True
      forceDestroy = False
    }
  }

  v1beta1.BucketVersioning {
    spec.forProvider: {
        bucketRef.name = oxr.metadata.name
    }
   }   if oxr.spec.versioning and oxr.status.conditions == 'True' else {}

   v1beta1.BucketServerSideEncryptionConfiguration {
    spec.forProvider = {
        bucketRef.name = oxr.metadata.name
        rule: [
          {
            applyServerSideEncryptionByDefault: [
                {
                    sseAlgorithm = "AES256"
                }
            ]
            bucketKeyEnabled = True
          }
        ]
    }
   } if oxr.spec.versioning and oxr.status.conditions == 'True' else {}
]

items = _items
