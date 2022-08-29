package com.kg.seeot.mybatis.product;

import java.util.List;

import com.kg.seeot.product.dto.ProductDTO;

public interface ProductMapper {
	public List<ProductDTO> allList();
	public List<ProductDTO> list(int productCategorie);
	public int productSave(ProductDTO dto);
	
	public ProductDTO productView(int productNo);

}
