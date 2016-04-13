module ProductsHelper
  def display_header
    return '
    <tr>
      <th>Prod_Num</th>
      <th>Prod_Name</th>
      <th>Prod_Alias</th>
      <th>Department</th>
    </tr>'.html_safe
  end

  def display_row(product)
    return "
    <tr>
      <td>#{product.Prod_Num}</td>
      <td>#{product.Prod_Name}</td>
      <td>#{product.Prod_Alias}</td>
      <td>#{product.Department}</td>
    </tr>".html_safe
  end
end
