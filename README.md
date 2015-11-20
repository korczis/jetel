# jetel

## Status

[![Gem Version](https://badge.fury.io/rb/jetel.svg)](http://badge.fury.io/rb/jetel) 
[![Downloads](http://img.shields.io/gem/dt/jetel.svg)](http://rubygems.org/gems/jetel)
[![Dependency Status](https://gemnasium.com/korczis/jetel.svg)](https://gemnasium.com/korczis/jetel)

## CLI - Command Line Interface

Run `jetel`

```
$ jetel

NAME
    jetel - Simple custom made tool for data download and basic ETL

SYNOPSIS
    jetel [global options] command [command options] [arguments...]

VERSION
    0.0.15

GLOBAL OPTIONS
    -d, --download_dir=download-dir - Download directory (default: data)
    --help                          - Show this message
    -l, --data_loader=data-loader   - Data Loader (default: pg://jetel:jetel@localhost:5432/jetel)
    -t, --timeout=download-timeout  - Download timeout (default: 600)
    --version                       - Display the program version

COMMANDS
    alexa, Alexa         - Module alexa
    config               - Show config
    downloaders          - Print downloaders info
    gadm, Gadm           - Module gadm
    geolite, Geolite     - Module geolite
    help                 - Shows a list of commands or help for one command
    ip, Ip               - Module ip
    iso3166, Iso3166     - Module iso3166
    loaders              - Print loaders info
    modules              - Print modules info
    nga, Nga             - Module nga
    sfpd, Sfpd           - Module sfpd
    tiger, Tiger         - Module tiger
    version              - Print version info
    wifileaks, Wifileaks - Module wifileaks
```

### Show help for command

```
$ jetel help geolite
NAME
    geolite - Module geolite

SYNOPSIS
    jetel [global options] geolite download
    jetel [global options] geolite extract
    jetel [global options] geolite load [--analyze_num_rows num] [--column_type column-name=column-type]
    jetel [global options] geolite transform

COMMANDS
    download  - download geolite
    extract   - extract geolite
    load      - load geolite
    transform - transform geolite
```


### Show help for subcommand

```
$ jetel help geolite download
NAME
    download - download geolite

SYNOPSIS
    jetel [global options] geolite download
```

### Show modules/sources

```
$ jetel modules
+-----------+---------------------------+
| Name      | Class                     |
+-----------+---------------------------+
| alexa     | Jetel::Modules::Alexa     |
| gadm      | Jetel::Modules::Gadm      |
| geolite   | Jetel::Modules::Geolite   |
| ip        | Jetel::Modules::Ip        |
| iso3166   | Jetel::Modules::Iso3166   |
| nga       | Jetel::Modules::Nga       |
| sfpd      | Jetel::Modules::Sfpd      |
| tiger     | Jetel::Modules::Tiger     |
| wifileaks | Jetel::Modules::Wifileaks |
+-----------+---------------------------+
```

### Show downloaders

```
$ jetel downloaders
+------+--------------------------+
| Name | Class                    |
+------+--------------------------+
| aria | Jetel::Downloaders::Aria |
| curl | Jetel::Downloaders::Curl |
| ruby | Jetel::Downloaders::Ruby |
| wget | Jetel::Downloaders::Wget |
+------+--------------------------+
```

### Show loaders

```
$ jetel loaders
+---------------+-------------------------------+
| Name          | Class                         |
+---------------+-------------------------------+
| couchbase     | Jetel::Loaders::Couchbase     |
| elasticsearch | Jetel::Loaders::Elasticsearch |
| pg            | Jetel::Loaders::Pg            |
+---------------+-------------------------------+
```

### Download source

```
$ jetel geolite download
Downloading http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip
aria2c -j 4 -t 600 -d "data/Geolite/geolite/downloaded" -o "GeoLite2-City-CSV.zip" http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip

11/06 17:51:35 [NOTICE] File already exists. Renamed to data/Geolite/geolite/downloaded/GeoLite2-City-CSV.zip.1.

11/06 17:51:35 [NOTICE] Allocating disk space. Use --file-allocation=none to disable it. See --file-allocation option in man page for more details.

11/06 17:51:48 [NOTICE] Download complete: data/Geolite/geolite/downloaded/GeoLite2-City-CSV.zip.1

Download Results:
gid   |stat|avg speed  |path/URI
======+====+===========+=======================================================
d0bf04|OK  |   2.4MiB/s|data/Geolite/geolite/downloaded/GeoLite2-City-CSV.zip.1

Status Legend:
(OK):download completed.
```

### Extract source

```
$ jetel geolite extract
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Blocks-IPv6.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-ja.csv
Extracting GeoLite2-City-CSV_20151103/COPYRIGHT.txt
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-zh-CN.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Blocks-IPv4.csv
Extracting GeoLite2-City-CSV_20151103/LICENSE.txt
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-fr.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-ru.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-en.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-pt-BR.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-de.csv
Extracting GeoLite2-City-CSV_20151103/GeoLite2-City-Locations-es.csv
```

### Transform source

```
$ jetel geolite transform
Transforming data/Geolite/geolite/extracted/GeoLite2-City-Blocks-IPv4.csv
```

### Load source

```
$ jetel geolite load --analyze_num_rows 50000
DROP TABLE IF EXISTS  "geolite";
CREATE TABLE "geolite"
(
  "network" CIDR NOT NULL,
  "geoname_id" BIGINT,
  "registered_country_geoname_id" BIGINT,
  "represented_country_geoname_id" TEXT,
  "is_anonymous_proxy" BOOLEAN NOT NULL,
  "is_satellite_provider" BOOLEAN NOT NULL,
  "postal_code" TEXT,
  "latitude" DECIMAL,
  "longitude" DECIMAL
)
WITH (
  OIDS=FALSE
);
COPY "geolite"
  FROM STDIN

    WITH DELIMITER ','

  CSV HEADER
;
3037320 row(s) affected
```

## Structure

```
.
├── bin
├── lib
│   └── jetel
│       ├── cli
│       │   └── cmd
│       ├── config
│       ├── downloaders
│       │   ├── aria
│       │   ├── curl
│       │   ├── ruby
│       │   └── wget
│       ├── extensions
│       ├── helpers
│       ├── loaders
│       │   ├── couchbase
│       │   ├── elasticsearch
│       │   └── pg
│       │       └── sql
│       └── modules
│           ├── alexa
│           ├── geolite
│           ├── ip
│           ├── iso3166
│           ├── nga
│           ├── sfpd
│           └── wifileaks
└── test
```

### Rake

```
$ rake -T
rake gem:build          # Build jetel-0.0.8.gem into the pkg directory
rake gem:install        # Build and install jetel-0.0.8.gem into system gems
rake gem:install:local  # Build and install jetel-0.0.8.gem into system gems without network access
rake gem:release        # Create tag v0.0.8 and build and push jetel-0.0.8.gem to Rubygems
```
