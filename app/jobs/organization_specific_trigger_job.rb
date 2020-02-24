# frozen_string_literal: true

class OrganizationSpecificTriggerJob < ApplicationJob
  def perform(job_clazz)
    Organization.find_each do |organization|
      job_clazz.constantize.perform_later(organization: organization)
    end
  end
end
