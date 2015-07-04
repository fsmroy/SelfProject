package com.beibei.erp.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Deliver {
    /**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.pk
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private Integer pk;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.deliver_id
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private String deliver_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.signer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private String signer;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.create_date
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private Date create_date;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.total
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private int total;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column deliver.customer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	private String customer;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.pk
	 * @return  the value of deliver.pk
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public Integer getPk() {
		return pk;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.pk
	 * @param pk  the value for deliver.pk
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setPk(Integer pk) {
		this.pk = pk;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.deliver_id
	 * @return  the value of deliver.deliver_id
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public String getDeliver_id() {
		return deliver_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.deliver_id
	 * @param deliver_id  the value for deliver.deliver_id
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setDeliver_id(String deliver_id) {
		this.deliver_id = deliver_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.signer
	 * @return  the value of deliver.signer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public String getSigner() {
		return signer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.signer
	 * @param signer  the value for deliver.signer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setSigner(String signer) {
		this.signer = signer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.create_date
	 * @return  the value of deliver.create_date
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public Date getCreate_date() {
		return create_date;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.create_date
	 * @param create_date  the value for deliver.create_date
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.total
	 * @return  the value of deliver.total
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public int getTotal() {
		return total;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.total
	 * @param total  the value for deliver.total
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setTotal(int total) {
		this.total = total;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column deliver.customer
	 * @return  the value of deliver.customer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public String getCustomer() {
		return customer;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column deliver.customer
	 * @param customer  the value for deliver.customer
	 * @mbggenerated  Mon Jun 15 22:50:26 CST 2015
	 */
	public void setCustomer(String customer) {
		this.customer = customer;
	}


	private List<DeliverDetail> deliverDetailList;

	public List<DeliverDetail> getDeliverDetailList() {
		return deliverDetailList;
	}

	public void setDeliverDetailList(List<DeliverDetail> deliverDetailList) {
		this.deliverDetailList = deliverDetailList;
	}
    
	
	private String createDate;
	private String jsonId;
	private List<DeliverDetail> children = new ArrayList<DeliverDetail>();

	
	
	public String getJsonId() {
		return jsonId;
	}

	public void setJsonId(String jsonId) {
		this.jsonId = jsonId;
	}

	public List<DeliverDetail> getChildren() {
		return children;
	}

	public void setChildren(List<DeliverDetail> children) {
		this.children = children;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
    
}