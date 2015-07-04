package com.beibei.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.beibei.erp.bean.Product;
import com.beibei.erp.bean.Purchase;
import com.beibei.erp.bean.PurchaseDetail;

@Service
public class PurchaseAction {
	@Autowired
	PurchaseDetailDao purchaseDetailDao;

	@Autowired
	PurchaseDao purchaseDao;
	
	@Autowired
	ProductDao productDao;

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void insertPurchaseData(Purchase purchase) {
		purchaseDao.insertHasDate(purchase);
		purchaseDetailDao.insertAll(purchase);
		Product product = null;
		for (PurchaseDetail detail : purchase.getPurchaseDetailList()) {
			int p_id = detail.getP_id();
			product = productDao.selectByPid(p_id);
			product.setP_count(product.getP_count() + detail.getP_count_in() + detail.getFree_count());
			productDao.updateByPrimaryKey(product);
		}
	}
}
