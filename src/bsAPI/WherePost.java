package bsAPI;

public class WherePost {
	
	private String[] where = {"基隆市","台北市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣",
			"南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","宜蘭縣","花蓮縣","台東縣","澎湖縣","金門縣","連江縣","海外地區"};
	
	public String getWherePost(int i) {
		return where[i];
	}
}
