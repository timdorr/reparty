require "rake"

shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "tasks/#{task_name.split(":").first}" }
  subject         { rake[task_name] }

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path)
    Rake::Task.define_task(:environment)
  end
end