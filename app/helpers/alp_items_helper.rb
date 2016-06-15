module AlpItemsHelper
  def display_header
    return '
    <tr>
      <th>Store</th>
      <th>Code</th>
      <th>Name</th>
      <th>中文</th>
      <th>Description</th>
      <th>Price</th>
      <th>Sale Price</th>
    </tr>'.html_safe
  end

  def display_row(item)
    p = item.onsale ? "white" : "pink"
    sp = item.onsale ? "pink" : "white"

    return "
    <tr>
      <td>#{item.store.name}</td>
      <td>#{item.code}</td>
      <td>#{item.name}</td>
      <td>#{item.alias}</td>
      <td>#{item.description}</td>
      <td style='background-color:#{p}'>#{item.price}</td>
      <td style='background-color:#{sp}'>#{item.sale_price}</td>
    </tr>".html_safe
  end

  def check_stores
    str = ''
    ['ALP', 'OFMM', 'OFC', 'OHS'].each do |store|
      str = str + "<div class='checkbox'><label><input type='checkbox' id='#{store}' name='#{store}' value='' checked>#{store}</label></div>"
    end
    return str.html_safe
  end

end
