class SneakerJob < ActiveJob::Base
  queue_as :default

  before_perform do |sneaker_job|
    job_id = sneaker_job.arguments.first
    job = Job.find_by({id: job_id})
    if job != nil then
      job.state = 'running'
      job.started_at = Time.now
      job.save
    end
  end

  after_perform do |sneaker_job|
    job_id = sneaker_job.arguments.first
    job = Job.find_by({id: job_id})
    if job != nil then
      job.state = 'completed'
      job.completed_at = Time.now
      job.save
    end
  end

  def perform(job_id, *args)
    logger.info "perform job:#{job_id}"
    job = Job.find_by({id: job_id})
    if job != nil then
      job.perform
    end
  end

end
