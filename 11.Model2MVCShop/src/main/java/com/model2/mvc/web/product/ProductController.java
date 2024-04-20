package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
//	@RequestMapping("/addProductView.do")
//	public String addUserView() throws Exception {
	@RequestMapping(value = "addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
//	@RequestMapping("/addProduct.do")
	@RequestMapping(value = "addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, 
			@RequestParam("imageFile") List<MultipartFile> imageFile,
			HttpServletRequest request) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		System.out.println("product============"+product);
		
		int size = imageFile.size();
		String uploadFileName = null;
		String webPath = "images/uploadFiles/";
		String uploadPath = request.getSession().getServletContext().getRealPath(webPath);
		
		System.out.println("uploadPath==="+uploadPath);
		
		for(int i = 0; i<size; i++) {
			String uuidFileName = null;
			String uuid = UUID.randomUUID().toString();
			
			MultipartFile file = imageFile.get(i);
			String fileName = file.getOriginalFilename();
			
			System.out.println("for문돌아나온fileName=="+fileName);
			
			uuidFileName = uuid+ "_" +fileName;
			
			File saveFile = new File(uploadPath, uuidFileName);
			
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(i==0) {
				uploadFileName = uuidFileName;
			} else {
				uploadFileName = uploadFileName +"-"+uuidFileName;
			}
			
		}
		
		System.out.println("uploadFileName=="+uploadFileName);
		
		//Business Logic
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		product.setFileName(uploadFileName);
		
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct/{prodNo}/{menu}", method=RequestMethod.GET)
	public String getProduct( @PathVariable Integer prodNo,
							@PathVariable String menu, Model model, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Cookie[] cookies = request.getCookies();
		
		String a = request.getRealPath(request.getServletPath());
		System.out.println("contextPath============================="+a);
		
		if (cookies != null) {
			for (Cookie coo : cookies) {
				if (coo.getName().equals("history")) {
					String cookieValue = coo.getValue();
					Cookie cookie = new Cookie("history", cookieValue+"and"+prodNo);
					cookie.setPath("/");
					response.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("history", String.valueOf(prodNo));
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		
		if (menu.equals("manage")) {
			return "forward:/product/updateProductView.jsp";
			//return "forward:/product/updateProductView.jsp?menu=request.getParameter("menu");
			
		} else { // request.getParameter("menu")가 search 또는 ok이면 넘어가게
			return "forward:/product/getProduct.jsp";
			
		}
	}
	
//	@RequestMapping("/updateProductView.do")
//	public String updateProductView( @RequestParam("prodNo") Integer prodNo , Model model ) throws Exception{
	@RequestMapping(value = "updateProduct/{prodNo}", method=RequestMethod.GET)
	public String updateProduct(@PathVariable Integer prodNo, Model model) throws Exception {

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
//	@RequestMapping("/updateProduct.do")
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, 
								@RequestParam("menu") String menu, Model model) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		productService.updateProduct(product);
		
		model.addAttribute("prodNo", product.getProdNo());
		
		return "redirect:/product/getProduct/"+product.getProdNo()+"/"+menu;
												
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct/{menu}")
	public String listProduct(@PathVariable String menu, @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
}