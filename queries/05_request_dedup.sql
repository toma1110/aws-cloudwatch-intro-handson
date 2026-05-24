fields @timestamp, @requestId, @message
| filter @message like /ERROR/ or @message like /Exception/
| sort @timestamp desc
| dedup @requestId
| limit 50
