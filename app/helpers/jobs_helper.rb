module JobsHelper
  def display_output(job)
    output = job.output
    return '' if output == nil
    if File.exist?(output) then
      return "<a href='/download/#{output}'>excel</a>".html_safe
    else
      return output
    end
  end

  def display_input(job)
    return "<a href='/download/#{job.input}'>excel</a>".html_safe
  end
end
