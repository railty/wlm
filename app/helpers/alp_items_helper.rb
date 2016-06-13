module AlpItemsHelper
  def display_header
    return '
    <tr>
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
      <td>#{link_to item.code, edit_alp_item_path(item)}</td>
      <td>#{item.name}</td>
      <td>#{item.alias}</td>
      <td>#{item.description}</td>
      <td style='background-color:#{p}'>#{item.price}</td>
      <td style='background-color:#{sp}'>#{item.sale_price}</td>
    </tr>".html_safe
  end

end
