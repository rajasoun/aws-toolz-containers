# dev-toolz-containers

Assembly of Dev Tools for DevSecOps


# Version Changing Utils

Use below utility to list Dockerfiles with Version Utils 

```sh
utils_with_version=(aws-crawl   gh    packer    terraform   terragrunt)
for util in $utils_with_version;do
    echo -e $util - $(cat $util/Dockerfile | grep 'ENV\|ARG' | grep '_VERSION' | grep -v '.zip\|amd64' | cut -d\  -f2-)
done
```