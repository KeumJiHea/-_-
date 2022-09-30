package com.kg.seeot.mybatis.product;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.dto.ProductManageDTO;

public interface ProductMapper {
	public List<ProductDTO> allList();
	public List<ProductDTO> list(int productCategorie);
	public ProductDTO productView(int productNo);
	public List<ProductDTO> productNameList(String productName);
	public List<ProductDTO> productNoList(int productNo);
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
	public int orderaddmodify(@Param("o")int orderStack, @Param("n") int productNo,  @Param("s") int productSize, @Param("c") String productColor);
	public int ordercancelmodify(@Param("o")int orderStack, @Param("n") int productNo,  @Param("s") int productSize, @Param("c") String productColor);
	
	
	public int allCount(@Param("productCategorie") int productCategorie, @Param("chkColor_arr") String[] chkColor_arr, @Param("chkPrice_arr") String[] chkPrice_arr);
	public List<ProductDTO> prolist(@Param("orderBy") String orderBy, @Param("productCategorie") int productCategorie, @Param("start") int start, @Param("end") int end, @Param("chkColor_arr") String[] chkColor_arr, @Param("chkPrice_arr") String[] chkPrice_arr);
	
	public int searchCount(@Param("keyword") String keyword, @Param("productCategorie") int productCategorie, @Param("chkColor_arr") String[] chkColor_arr, @Param("chkPrice_arr") String[] chkPrice_arr);
	public List<ProductDTO> searchList(@Param("keyword") String keyword, @Param("productCategorie") int productCategorie, @Param("orderBy") String orderBy, @Param("start") int start, @Param("end") int end, @Param("chkColor_arr") String[] chkColor_arr, @Param("chkPrice_arr") String[] chkPrice_arr);
}
