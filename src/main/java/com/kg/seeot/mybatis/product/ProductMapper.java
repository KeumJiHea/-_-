package com.kg.seeot.mybatis.product;

import java.util.List;

import com.kg.seeot.product.dto.ProductDTO;

public interface ProductMapper {
	public List<ProductDTO> productAllList();
	public List<ProductDTO> list(int productCategorie);

}
