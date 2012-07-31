require 'spec_helper'
require 'pry'

module Asana
  describe Workspace do
    use_vcr_cassette
    before do
      authorize_with_asana
    end

    let(:workspace) { Asana::Workspace.first }

    describe "Showing available workspaces" do
      specify do
        #binding.pry
        Asana::Workspace.all.first.should be_instance_of Asana::Workspace
      end
    end

    pending "Updating an existing workspace (name only)"

    describe ".create_task" do
      specify do
        task = workspace.create_task(name: "test .create_task")
        task.should be_instance_of Asana::Task
        task.name.should == "test .create_task"
      end
    end

    describe ".create_tag" do
      let(:tag_name) { "tag #{Date.today}" }
      subject { workspace.create_tag(name: tag_name)}

      it { should be_instance_of Asana::Tag}
      its(:name) { should == tag_name }
    end

    describe ".tasks" do
      subject { workspace }
      its(:tasks) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tasks.first.should be_instance_of Task
      end
    end

    describe "tags" do
      subject { workspace }
      its(:tags) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tags.first.should be_instance_of Tag
      end
    end
  end
end
