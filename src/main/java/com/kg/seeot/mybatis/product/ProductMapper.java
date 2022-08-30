package com.kg.seeot.mybatis.product;

import java.util.List;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

public interface ProductMapper {
	public List<ProductDTO> allList();
	public List<ProductDTO> list(int productCategorie);
	public ProductDTO productView(int productNo);
	public List<ProductManageDTO> productManageView(int productNo);
	public int productSave(ProductDTO pdto);
	public int productManageSave(ProductManageDTO mdto);
	public int productDelete(int productNo);
	
	public int productModify(ProductDTO dto);
	
}
