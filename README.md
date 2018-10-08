# template6
This template installs a MongoDB server as container.

* Data Container: It uses a specified data volume container that might be created if it not exist yet.
* Dockerfile: There is no Dockerfile because the MongoDb image run basically out of the box.
* Credentials: No access restrictions, i.e. no user/pass is set. Make sure nobody have access to the host server
* smallfiles: The `--smallfiles` flag is applied

## How to use
1) Download

```
git clone git@github.com:waalfisk/template6.git mynewname
cd mynewname
```

2) Edit `config.conf` to your needs

## Use cases
* ELT (Data Lake), cleansed data layer, i.e.
    * "load" raw data into "cleansed" data layer
    * start the actual cleaning (create clean key-values)
    * offer clean key-values for "transform" process to pull

## Commands
Use the following commands to install, start, or uninstall the images or container.

| command | description |
|:-------:|:-----------:|
| `./config uninstall` | Cleanup previous installations |
| `vi config.conf` | Increment the version |
| `./config.sh run` | Instantiate a new MongoDB container |
| `./config.sh start` | Start the Container again |

Requires execution rights for `config.sh`.
For example, run `chmod u+x config.sh` to call `./config.sh ...`.
Otherwise call `bash config.sh ...`.

## Links
* [template6](https://github.com/waalfisk/template6)
