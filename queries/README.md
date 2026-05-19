# Logs Insights Query Set

CloudWatch入門講座で読むためのLogs Insightsクエリ集です。既存ロググループがある場合だけ、短い時間範囲で任意実行してください。

| File | Purpose |
| --- | --- |
| `01_recent_logs.sql` | 直近ログを新しい順に見る |
| `02_error_search.sql` | エラーらしいログを探す |
| `03_error_trend.sql` | 時間ごとのエラー件数を集計する |
| `04_lambda_slow_reports.sql` | Lambda REPORTログから遅い実行を探す |
| `05_request_dedup.sql` | requestId単位で重複を抑える |

実行前に、対象ロググループと時間範囲を必要最小限に絞ってください。
