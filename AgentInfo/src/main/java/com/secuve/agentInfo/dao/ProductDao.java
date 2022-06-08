package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Product;

@Repository
public class ProductDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Product> getProductList(Product search) {
		return sqlSession.selectList("product.getProduct", search);
	}

	public int getProductListCount(Product search) {
		return sqlSession.selectOne("product.getProductCount", search);
	}

	public int getProductKeyNum() {
		return sqlSession.selectOne("product.getProductKeyNum");
	}

	public int insertProduct(Product product) {
		return sqlSession.insert("product.insertProduct", product);
	}

	public Product getProductOne(int productKeyNum) {
		return sqlSession.selectOne("product.getProductOne", productKeyNum);
	}

	public int updateProduct(Product product) {
		return sqlSession.update("product.updateProduct", product);
	}

	public int delProduct(int productKeyNum) {
		return sqlSession.delete("product.delProduct", productKeyNum);
	}
}
