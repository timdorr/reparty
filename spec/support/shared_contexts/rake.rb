require "rake"

shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(":").first}" }
  subject         { rake[task_name] }

  def exclude_current_task
    $".reject {|file| file == Reparty.root.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Reparty.root], exclude_current_task)
    Rake::Task.define_task(:environment)
  end
end