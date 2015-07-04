package com.beibei.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.beibei.erp.bean.Deliver;
import com.beibei.erp.bean.DeliverDetail;
import com.beibei.erp.bean.Product;


@Service
public class DeliverAction {
	@Autowired
	DeliverDetailDao deliverDetailDao;

	@Autowired
	DeliverDao deliverDao;
	
	@Autowired
	ProductDao productDao;

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void insertDeliverData(Deliver deliver) {
		deliverDao.insertHasDate(deliver);
		deliverDetailDao.insertAll(deliver);
		Product product = null;
		for (DeliverDetail detail : deliver.getDeliverDetailList()) {
			int p_id = detail.getP_id();
			product = productDao.selectByPid(p_id);
			product.setP_count(product.getP_count() - detail.getP_count_out());
			productDao.updateByPrimaryKey(product);
		}
	}
}
