/**
 * 
 */
package com.project.sm.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.sm.service.CartService;
import com.project.sm.service.ProductService;
import com.project.sm.vo.CartVO;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Controller
@RequestMapping("/cart")
@Slf4j
public class CartController {
	
	@Inject
	CartService service;
	
	@Inject
	ProductService productService;
	
	
	@RequestMapping("insert.do")
	public String insertCart(@ModelAttribute("cartForm") CartVO cart, Model model, HttpSession session) {
		
		log.info("cart = "+cart);
		
		String result = "";
		
		if(cart.getMemberId() != "") {
			if(service.insertCart(cart) == true) {
				session.setAttribute("cartCount", (int)session.getAttribute("cartCount")+1);
				result = "redirect:/cart/list.do";
			} else {
				model.addAttribute("msg", "cart insert fail");
				model.addAttribute("productId", cart.getProductId());
				result = "home";
			}
		} else {
			model.addAttribute("num", 4);
			result = "/member/member_login";
		}
		return result;
	}
	
	
	@RequestMapping("list.do")
	public String listCart(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("id");
		
		log.info("id = "+memberId);
		
		List<CartVO> carts = service.listCart(memberId);
		List<ProductVO> products = new ArrayList<>();
		
		Iterator<CartVO> it = carts.iterator();
		
		while(it.hasNext()) {
			products.add(productService.viewProduct(it.next().getProductId()));
		}
		
		model.addAttribute("carts", carts);
		model.addAttribute("products", products);
		
		return "/cart/cart_list";
	}
	
	
	@ResponseBody
	@RequestMapping(value="update.do", produces="application/json; charset=UTF-8")
	public String updateCart(@RequestParam("cartNum") int cartNum,
							 @RequestParam("cartCount") int cartCount) throws JsonProcessingException {
		
		CartVO cart = new CartVO();
		cart.setCartNum(cartNum);
		cart.setCartCount(cartCount);
		
		String result = String.valueOf(service.updateCart(cart));
		
		return new ObjectMapper().writeValueAsString(result);
	}
	
	@ResponseBody
	@RequestMapping(value="delete.do", produces="application/json; charset=UTF-8")
	public String deleteCart(@RequestParam("cartNum") int[] cartNum, HttpSession session) throws JsonProcessingException {
		
		CartVO cart = new CartVO();

		// log.info("count = "+cartNum.length);
		
		
		for(int i=0; i<cartNum.length; i++) {
			cart.setCartNum(cartNum[i]);
			cart.setMemberId((String) session.getAttribute("id"));
			
			log.info("cartNum = "+cartNum[i]);
			service.deleteCart(cart);
		}
		
		session.setAttribute("cartCount", (int)(session.getAttribute("cartCount"))-cartNum.length);
		int count = (int) (session.getAttribute("cartCount"));
		
		return new ObjectMapper().writeValueAsString(String.valueOf(count));
	}

}
