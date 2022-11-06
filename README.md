# dev-toolz-containers

Assembly of Dev Tools for DevSecOps


# Version Changing Utils

Use below utility to list Dockerfiles with Version Utils 

```sh
utils_with_version=(aws-crawl   gh    packer    terraform   terragrunt teller)
for util in $utils_with_version;do
    echo -e $util - $(cat $util/Dockerfile | grep 'ENV\|ARG' | grep '_VERSION' | grep -v '.zip\|amd64' | cut -d\  -f2-)
done
```

After Version Upgrade

```sh
utils_with_version=(aws-crawl   gh    packer    terraform   terragrunt teller)
for util in $utils_with_version;do
    ./assist.sh build $util && ./assist.sh push $util
done
./assist.sh build aws-assembly  && ./assist.sh push aws-assembly 
./assist.sh build aws-all-in-one && ./assist.sh push aws-all-in-one
```