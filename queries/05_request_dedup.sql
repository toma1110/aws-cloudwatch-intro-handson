fields @timestamp, @requestId, @message
| filter @message like /ERROR/ or @message like /Exception/
| dedup @requestId
| sort @timestamp desc
| limit 50
