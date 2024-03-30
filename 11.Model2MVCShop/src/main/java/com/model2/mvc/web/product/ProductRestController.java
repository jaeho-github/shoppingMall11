package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 상품관리 Controller
@RestController
@RequestMapping("/app/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties, classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct/{prodNo}/{menu}", method=RequestMethod.GET)
	public Map getProduct( @PathVariable Integer prodNo,
							@PathVariable String menu, Model model) throws Exception {
		
		System.out.println("/app/product/getProduct : GET");
		System.out.println(prodNo + " :: " + menu);
		Product product = productService.getProduct(prodNo);
		
		Map resultMap = new HashMap();
		resultMap.put("product", product);
		resultMap.put("menu", menu);
		
		return resultMap;
	}
	
//	@RequestMapping("/updateProductView.do")
//	public String updateProductView( @RequestParam("prodNo") Integer prodNo , Model model ) throws Exception{
	@RequestMapping(value = "updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct(@PathVariable Integer prodNo, Model model) throws Exception {

		System.out.println("/app/product/updateProduct : GET");		
		
		return productService.getProduct(prodNo);
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct/{menu}", method=RequestMethod.GET)
	public Map listProduct(@PathVariable String menu, @ModelAttribute("search") Search search, HttpServletRequest request) throws Exception{
		
		System.out.println("/app/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		Map resultMap = new HashMap();
		resultMap.put("list", map.get("list"));
		resultMap.put("resultPage", resultPage);
		resultMap.put("search", search);
		resultMap.put("menu", menu);
		
		return resultMap;
	}
	
	@RequestMapping(value = "listProduct/{menu}", method=RequestMethod.POST)
	public Map listProduct(@PathVariable String menu, @RequestBody Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/app/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		Map resultMap = new HashMap();
		resultMap.put("list", map.get("list"));
		resultMap.put("resultPage", resultPage);
		resultMap.put("search", search);
		resultMap.put("menu", menu);
		
		return resultMap;
	}
}