# Source To Image Scala Liquibase

Source to image for Scala applicaitons that use Liquibase.

This image layers [Liquibase](http://www.liquibase.org) on top of [OutThereLabs/s2i-scala](https://github.com/OutThereLabs/s2i-liquibase).

## Instillation

Import from [Docker Hub](https://hub.docker.com/r/outtherelabs/s2i-scala-liquibase/)

```shell
$ oc import-image scala-liquibase --from outtherelabs/s2i-scala-liquibase
```

Or build on your OpenShift cluster with:

```shell
$ oc process -f https://raw.githubusercontent.com/OutThereLabs/s2i-scala-liquibase/master/template.yaml | oc create -f -
```
