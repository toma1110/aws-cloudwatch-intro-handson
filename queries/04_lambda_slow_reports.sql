filter @type = "REPORT"
| fields @timestamp, @requestId, @duration, @billedDuration, @memorySize, @maxMemoryUsed
| filter @duration > 1000
| sort @duration desc
| limit 20
