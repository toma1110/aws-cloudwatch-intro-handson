fields @timestamp, @message
| filter @message like /ERROR/ or @message like /Exception/
| stats count(*) as errorCount by bin(5m)
| sort @timestamp desc
