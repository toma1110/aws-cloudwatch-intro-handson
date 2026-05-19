# AWS CloudWatch入門 ハンズオン資料

Udemy講座 `AWS CloudWatch入門: Metrics・Logs Insights・Alarm・Dashboardで学ぶ監視の基本` の公開用ハンズオン資料です。

このハンズオンは、CloudWatchの主要部品を作る前に説明できる状態にすることを目的にしています。標準手順ではAWSリソースを新規作成しません。AWSアカウントや既存ロググループがない場合でも、ワークシートとクエリ読解だけで完了できます。

## Public URL

```text
https://github.com/toma1110/aws-cloudwatch-intro-handson
```

## Prerequisites

- AWSマネジメントコンソールの基本的な画面遷移を見たことがある
- AWSアカウントは任意
- 既存ロググループは任意
- AWS CLI、CloudFormation、CDK、Terraformは不要

## Do Not Create Resources

このハンズオンでは以下を作成しません。

- CloudWatch Dashboard
- CloudWatch Alarm
- Custom Metric
- Log Group
- SNS Topic
- CloudFormation stack
- サンプルアプリケーション

## Cost Safety

このREADME通りにワークシートを読むだけなら、AWS料金は発生しません。

既存ロググループに対してLogs Insightsを任意実行する場合は、スキャンしたログデータ量に応じて料金が発生する可能性があります。

- 必要なロググループだけを選ぶ
- 時間範囲を直近5分から15分程度に絞る
- 不要なクエリはキャンセルする
- ダッシュボードにLogs Insights結果を追加しない
- 手順外でリソースを作成しない

## Hands-on Index

| Lecture | Title | Hands-on | Resource |
| --- | --- | --- | --- |
| `s1-l1` | CloudWatchの地図 | あり | [Step 1: CloudWatch Map Worksheet](#step-1-cloudwatch-map-worksheet) |
| `s1-l2` | Metricsの基本 | あり | [Step 2: Metrics Check](#step-2-metrics-check) |
| `s1-l3` | Logsの基本 | あり | [Step 4: Logs Check](#step-4-logs-check) |
| `s1-l4` | Metricsの保持期間と料金 | あり | [Step 3: Metrics Retention and Cost](#step-3-metrics-retention-and-cost) |
| `s2-l1` | Logs Insights入門 | あり | [Step 5: Logs Insights Query Reading](#step-5-logs-insights-query-reading) |
| `s2-l2` | Logs Insightsで障害調査 | あり | [Step 6: Incident Query Patterns](#step-6-incident-query-patterns) |
| `s3-l1` | Alarm/Dashboardと次の一歩 | あり | [Step 7: Alarm and Dashboard Check](#step-7-alarm-and-dashboard-check) |

## Step 1: CloudWatch Map Worksheet

CloudWatchの基本部品を、まず言葉で整理します。

| 部品 | 何を見るか | ひとことで |
| --- | --- | --- |
| Metrics | 数値の時系列 | どれくらいか |
| Logs | 出来事の記録 | 何が起きたか |
| Logs Insights | ログ検索と集計 | どこで何が多いか |
| Alarm | 条件と状態 | 危ないか |
| Dashboard | 表示面 | まとめて見る |

以下を自分の言葉で埋めます。

| 質問 | 回答 |
| --- | --- |
| Metricsは何を見る場所か |  |
| Logsは何を見る場所か |  |
| Logs Insightsは何をする場所か |  |
| Alarmは何を判断するものか |  |
| Dashboardは何のために使うか |  |
| 障害時は最初にどこを見るか |  |

## Step 2: Metrics Check

AWSアカウントがある場合だけ、CloudWatchコンソールで既存メトリクスの場所を確認します。

1. AWSマネジメントコンソールでCloudWatchを開く。
2. 左メニューからMetricsを開く。
3. `AWS/EC2`、`AWS/Lambda`、`AWS/Billing` などのnamespaceが見えるか確認する。
4. 既存リソースがない場合は、namespaceが少なくても問題ありません。

| 観点 | メモ |
| --- | --- |
| namespace | サービスや用途ごとのメトリクスの棚 |
| metric | 時間ごとに並ぶ数値 |
| dimension | どの対象の数値かを決めるラベル |
| statistic | 平均、最大、合計など、期間内のまとめ方 |
| period | 1分、5分など、集計する時間幅 |

## Step 3: Metrics Retention and Cost

このコースではメトリクスを新規送信しません。既存メトリクスを見る時に知っておくべき保管期間と料金の観点だけを整理します。

| 観点 | メモ |
| --- | --- |
| 標準メトリクス | 多くのAWSサービスが自動で送る基本メトリクス |
| カスタムメトリクス | アプリや運用者が追加で送るメトリクス。数やディメンション設計が料金に影響する |
| 詳細監視 | より細かい間隔で送られるメトリクス。必要な対象だけ有効化する |
| 保持期間 | 古いデータほど粗い粒度へ集約されるため、長期比較では見える細かさが変わる |
| 料金確認 | カスタムメトリクス数、API呼び出し、アラーム、ダッシュボード、ログ検索を分けて見る |

この入門では、`PutMetricData`、CloudWatch Agent、埋め込みメトリクスフォーマット、OpenTelemetryの実装手順は扱いません。

## Step 4: Logs Check

AWSアカウントがある場合だけ、CloudWatch Logsの場所を確認します。

1. CloudWatchの左メニューからLogsを開く。
2. Log groupsを確認する。
3. 既存アプリケーションがなければ、ロググループが空でも問題ありません。

| 観点 | メモ |
| --- | --- |
| log group | ログのまとまり |
| log stream | 同じまとまり内の細かい流れ |
| log event | 時刻とメッセージを持つ1つの出来事 |
| metricsとの違い | 数値ではなく出来事の記録 |

## Step 5: Logs Insights Query Reading

既存ロググループがある場合だけ、CloudWatch Logs Insightsを開きます。実行する場合は、時間範囲を直近5分から15分程度に絞ります。

| Query | File | Purpose |
| --- | --- | --- |
| 最近のログを見る | [queries/01_recent_logs.sql](queries/01_recent_logs.sql) | 直近ログを新しい順に確認する |
| エラーらしいログを見る | [queries/02_error_search.sql](queries/02_error_search.sql) | `ERROR` を含むログを探す |
| 時間ごとの件数を見る | [queries/03_error_trend.sql](queries/03_error_trend.sql) | `stats` と `bin()` を読む |

## Step 6: Incident Query Patterns

このセクションは、実行しなくても読解で完了できます。対象ログの形式によって、そのまま動かない場合があります。

| Query | File | Purpose |
| --- | --- | --- |
| 最近のエラー | [queries/02_error_search.sql](queries/02_error_search.sql) | `ERROR`、`Exception`、`timeout` の入口 |
| ラムダ関数の遅い実行を探す | [queries/04_lambda_slow_reports.sql](queries/04_lambda_slow_reports.sql) | Lambda REPORTログの見方を読む |
| リクエスト単位で重複を抑える | [queries/05_request_dedup.sql](queries/05_request_dedup.sql) | `requestId` と `dedup` を読む |

## Step 7: Alarm and Dashboard Check

AWSアカウントがある場合だけ、既存のAlarmとDashboardの場所を確認します。新規作成はしません。

### Alarm

1. CloudWatchの左メニューからAlarmsを開く。
2. All alarmsを確認する。
3. 既存アラームがなくても問題ありません。

| 観点 | メモ |
| --- | --- |
| OK | 条件を超えていない状態 |
| ALARM | 条件を超えている状態 |
| INSUFFICIENT_DATA | 判断に必要なデータが足りない状態 |
| action | 通知や自動処理につながる部分 |

### Dashboard

1. CloudWatchの左メニューからDashboardsを開く。
2. 既存ダッシュボードがあるか確認する。
3. 新規作成はしません。

| 観点 | メモ |
| --- | --- |
| Dashboard | メトリクスやアラームを見る表示面 |
| 保存場所ではない | 元データはMetricsやLogs側にある |
| 障害時の入口 | 何が悪化しているかを大きく見る |

## IaC Positioning

本コースではCloudFormationテンプレートを使いません。CloudFormationは、受講者が追加ツールなしで再現しやすい教材ハンズオンの選択肢です。実運用のIaCでは、チーム開発、抽象化、保守性を考慮してCDKまたはTerraformを推奨します。
