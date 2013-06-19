## 0.5.0

- Weekly emails (hack-ish for now...)
- Allow reports to have an interval (1 for daily, 7 for weekly)
- Add Mixpanel funnel report

## 0.3.2

- Separate out graph types for counter and gauge graphs
- Rotate through colors for each graph to provide variety

## 0.3.1

- Total graphs were off by one day

## 0.3.0

- Add Sendgrid report
- A few more possibly timezone fixes
- Add HTTParty as a dependency. (Great library name, by the way!)

## 0.2.1

- Timezone fix (ActiveRecord always saves in UTC)

## 0.2.0

- Much improved email template

## 0.1.3

- Better testing and coverage.
- Fixed grouping of items by date. Now groups by day, not by time period.
- Support scopes in ActiveRecord report
- Add an email title configuration (config.title)

## 0.1.2

- Accidentally included rake task twice by defining both an Engine and a Railtie
- Add :total to ActiveRecord report types

## 0.1.0

- Initial release