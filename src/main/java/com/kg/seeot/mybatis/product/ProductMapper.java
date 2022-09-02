package com.kg.seeot.mybatis.product;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

public interface ProductMapper {
	public List<ProductDTO> allList();
	public List<ProductDTO> list(int productCategorie);
	public ProductDTO productView(int productNo);
	public List<ProductManageDTO> managementSize(int productNo);
	public List<ProductManageDTO> managementColor(int productNo);
	public List<ProductManageDTO> productManageView(int productNo);
	public int productSave(ProductDTO pdto);
	public int productManageSave(ProductManageDTO mdto);
	public int productDelete(int productNo);
	
	public int productModify(ProductDTO dto);
	public int managementDelete(@Param("productNo") int productNo,  @Param("productSize") int productSize, @Param("productColor") String productColor);
	public ProductManageDTO managementModify_Form(@Param("productNo") int productNo,  @Param("productSize") int productSize, @Param("productColor") String productColor);
	public int managementModify( @Param("productNo") int productNo, @Param("productStack") int productStack,  @Param("productColor") String productColor,  @Param("productSize") int productSize, @Param("moProductStack") int moProductStack, @Param("moProductColor") String moProductColor, @Param("moProductSize") int moProductSize);
	
}
