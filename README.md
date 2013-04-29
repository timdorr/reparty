# Reparty [![Build Status](https://travis-ci.org/timdorr/reparty.png?branch=master)](https://travis-ci.org/timdorr/reparty) [![Dependency Status](https://gemnasium.com/timdorr/reparty.png)](https://gemnasium.com/timdorr/reparty) [![Code Climate](https://codeclimate.com/github/timdorr/reparty.png)](https://codeclimate.com/github/timdorr/reparty)

__A business analytics reporting party!__

Although initially concentrating on a daily email report, Reparty intends to be an easy 
tool for building dashboards and reports focused on business analytics about your app. 

Planned reporting modules include:

* ActiveRecord, including arbitrary sum/count columns
* Google Analytics/MixPanel/Gaug.es/etc etc
* Stripe
* Twitter

## Configuration

Whilst not completely done, this is how you'll configure it for emailing a daily user count in the near future.

    Reparty.config do |config|
      config.from = "test@test.com"
      config.subject = "SalesLoft JCA Daily Report"
    
      config.add_report Reparty::Report::ActiveRecord, :user, :count
    end

## Usage

Generating an email is as simple as a rake task:

    rake reparty:email[someone@somewhere.com]

You can run this in a cron job or other scheduling system.
