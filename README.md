# Reparty [![Build Status](https://travis-ci.org/timdorr/reparty.png?branch=master)](https://travis-ci.org/timdorr/reparty) [![Dependency Status](https://gemnasium.com/timdorr/reparty.png)](https://gemnasium.com/timdorr/reparty) [![Code Climate](https://codeclimate.com/github/timdorr/reparty.png)](https://codeclimate.com/github/timdorr/reparty)

__A business analytics reporting party!__

Although initially concentrating on a daily email report, Reparty intends to be an easy 
tool for generating reports focused on business analytics about your app.

A modular design is used, so reporting on a variety of different data sources is possible.
Custom modules can be created within your app. The currently bundled modules are:

* ActiveRecord, including arbitrary sum/count columns
* SendGrid
* Mixpanel (just funnels for now)

Other modules will be added over time. This is in use in production at my company, SalesLoft,
so focus will be on the modules that best suit our needs. Feel free to submit a pull request
with any modules you have created.

## Configuration

You can configure Reparty in an initalizer using a config block:

    Reparty.config do |config|
      config.from = "test@test.com"
      config.subject = "SalesLoft JCA Daily Report"
    
      config.add_report Reparty::Report::ActiveRecord, "New User Signups", :user
    end

Better documentation of Reparty and each individual module's configuration is coming. For now,
 you'll just have to read the code (sorry!). Check the test suite for examples.

## Usage

Generating an email is as simple as a rake task:

    rake reparty:email[someone@somewhere.com]

You can run this in a cron job or other scheduling system. A weekly email is currently hacked
in to the code, which you can run using it's separate rake task:

    rake reparty:weekly_email[someone@somewhere.com]

This will likely change in the future, so watch out when upgrading!