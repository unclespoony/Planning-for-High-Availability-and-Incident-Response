# API Service

| Category     | SLI | SLO                                                                                                         |
|--------------|-----|-------------------------------------------------------------------------------------------------------------|
| Availability |   total number of successful requests / total number of requests  | 99%                                                                                                         |
| Latency      |   buckets of requests in a histogram showing the 90th percentile over the last 5 minuttes  | 90% of requests below 100ms                                                                                 |
| Error Budget |   percentage of remaining error budget  | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   |   total number of successful requests over 5 minutes  | 5 RPS indicates the application is functioning                                                              |
