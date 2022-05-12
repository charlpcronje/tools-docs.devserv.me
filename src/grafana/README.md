# Prometheus and Grafana Tutorial - Server Monitoring

- I'm deploying all of this as containers with `docker` and portainer `web ui`

The two stacks can be deployed one by one, or both at the same time in one `docker-compose.yml` file.

> Here are the two individiul compose files:

- [prometheus/docker-compose.yml](prometheus/docker-compose.yml)
- [grafana/docker-compose.yml](grafana/docker-compose.yml)

## Combined Compose

- [combined/docker-compose.yml](combined/docker-compose.yml)


## Create prometheus.yml file

```sh
mkdir /etc/prometheus
```

- Add the following into `/etc/prometheus/prometheus.yml`

```yml
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  # external_labels:
  # monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  # Example job for node_exporter
  # - job_name: 'node_exporter'
  #   static_configs:
  #     - targets: ['node_exporter:9100']

  # Example job for cadvisor
  # - job_name: 'cadvisor'
  #   static_configs:
  #     - targets: ['cadvisor:8080']

```

## Add Exporters and Integrations

### Add Node exporter

Add the following to your combined docker-composer.yml file so that all the containers run on the same docker network so that no ports need to be exposed

```yml

```






