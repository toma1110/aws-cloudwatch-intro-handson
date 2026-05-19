fields @timestamp, @message, @logStream
| filter @message like /ERROR/ or @message like /Exception/ or @message like /timeout/
| sort @timestamp desc
| limit 100
