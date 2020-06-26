package myBean.DB;

public class Article {
	private int idx;
	private String id;
	private String name;
	private String birth;
	private String pwd;
	
	public Article() {}
	
	public void setIdx(int idx) {
		this.idx=idx;
	}
	public void setId(String id) {
		this.id=id;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setBirth(String birth) {
		this.birth=birth;
	}
	public void setPwd(String pwd) {
		this.pwd=pwd;
	}
	public int getIdx() {
		return idx;
	}
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getBirth() {
		return birth;
	}
	public String getPwd() {
		return pwd;
	}
}
