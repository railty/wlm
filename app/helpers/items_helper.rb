module ItemsHelper
  def display_header
    return Rails.application.config.site == "hq" ? '
    <tr>
      <th>Item Number</th>
      <th>UPC</th>
      <th>Price Ceiling</th>
      <th>Unit Cost</th>
      <th>Measure</th>
      <th>Description</th>
      <th>ALP Prod Num</th>
      <th>中文</th>
      <th>Status</th>
      <th>Type</th>
    </tr>'.html_safe : '
    <tr>
      <th>Item Number</th>
      <th>UPC</th>
      <th>Price Ceiling</th>
      <th>Price</th>
      <th>Proposed Price</th>
      <th>Unit Cost</th>
      <th>Origin</th>
      <th>Measure</th>
      <th>Description</th>
      <th>ALP Prod Num</th>
      <th>中文</th>
      <th>Status</th>
      <th>Type</th>
      <th>Action</th>
    </tr>'.html_safe
  end

  def display_row(item)
    return Rails.application.config.site == "hq" ? "
    <tr>
      <td>#{item.id}</td>
      <td>#{item.upc}</td>
      <td>#{number_to_currency(item.price_ceiling)}</td>
      <td>#{number_to_currency(item.unit_cost || 0)}</td>
      <td>#{item.unit_size_uom}</td>
      <td>#{item.signing_desc}</td>
      <td>#{item.vendor_stk_nbr}</td>
      <td>#{item.products_store==nil ? '' : item.products_store.Prod_Alias}</td>
      <td>#{item.wm_item==nil ? '' : item.wm_item.Item_Status}</td>
      <td>#{item.wm_item==nil ? '' : item.wm_item.Item_Type}</td>
    </tr>".html_safe : "
    <tr>
      <td>#{item.id}</td>
      <td>#{item.upc}</td>
      <td>#{number_to_currency(item.price_ceiling)}</td>
      <td>#{number_to_currency(item.unit_retail)}</td>
      <td>#{link_to number_to_currency(item.proposed_price || 0), edit_item_path(item)}</td>
      <td>#{number_to_currency(item.unit_cost || 0)}</td>
      <td>#{link_to item.origin || 'Unknown', edit_item_path(item)}</td>
      <td>#{item.unit_size_uom}</td>
      <td>#{item.signing_desc}</td>
      <td>#{item.vendor_stk_nbr}</td>
      <td>#{item.products_store==nil ? '' : item.products_store.Prod_Alias}</td>
      <td>#{item.wm_item.Item_Status}</td>
      <td>#{item.wm_item.Item_Type}</td>
      <td>#{link_to "Print",  print_item_path(item)}</td>
    </tr>".html_safe
  end
end
