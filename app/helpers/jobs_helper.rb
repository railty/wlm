module JobsHelper
  def display_output(job)
    output = job.output
    return '' if output == nil

    if ['pricing_guide'].include?(job.job_type) then
      if File.exist?(output) then
        return "<a href='/download/#{output}'>excel</a>".html_safe
      end
    end
    return output
  end

  def display_input(job)
    if ['import_alp_products','import_wm_products','pricing_guide'].include?(job.job_type) then
      return "<a href='/download/#{job.input}'>excel</a>".html_safe
    else
      return ''
    end
  end

  def table_head
    return "<thead>
              <tr>
                <th>Time</th>
                <th>Job</th>
                <th>State</th>
                <th>Input</th>
                <th>Output</th>
                <th>Time</th>
                <th>Delete</th>
              </tr>
            </thead>".html_safe
  end

  def display_job(job)
    return "<tr>
              <td>#{job.enqueued_at.strftime('%Y-%m-%d %H:%M')}</td>
              <td>#{job.name}</td>
              <td>#{job.state}</td>
              <td>#{display_input(job)}</td>
              <td>#{display_output(job)}</td>
              <td>#{job.completed_at==nil ? 0 : (job.completed_at-job.started_at).to_i.to_s + ' seconds'}</td>
              <td>#{link_to('Destroy', job, method: :delete, data: {confirm: 'Are you sure?'})}</td>
            </tr>".html_safe
  end

  def check_stores
    str = ''
    ['HQSVR2', 'WM1080', 'ALP', 'OFMM', 'OFC', 'OHS'].each do |store|
      state = store=='HQSVR2' ? 'disabled' : 'enabled'
      str = str + "<div class='checkbox #{state}'><label><input type='checkbox' value='' #{state} checked>#{store}</label></div>"
    end
    return str.html_safe
  end
end
