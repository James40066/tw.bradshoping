package bsAPI;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.LinkedList;

import javax.imageio.ImageIO;

//負責圖片縮小邏輯並返回HashMap<String, String> photoName
public class Compress_pictures {

	private HashMap<String, String> photoName;
	private double rateB, rateS;
	private int Bdx, Bdy, Sdx, Sdy;
	private boolean isWidthBig;
	private BufferedImage bufferedImageBig, bufferedImageSmall;

	// 目標=>圖片縮放成兩種大(690)and小(163)跟原圖,並output進資料夾
	public HashMap<String, String> scaleImage(InputStream inputStream, int id, String path, int photoNum, String type) {
		try {
			// 接收圖片串流
			BufferedImage src = javax.imageio.ImageIO.read(inputStream);

			// 為等比縮放計算輸出圖片所要乘的數值
			// 縮放比例=圖片長寬/想縮放的長寬

			double rateWBig = ((double) src.getWidth(null)) / (double) 690;
			double rateHBig = ((double) src.getHeight(null)) / (double) 690;

			double rateWSmall = ((double) src.getWidth(null)) / (double) 163;
			double rateHSmall = ((double) src.getHeight(null)) / (double) 163;

			// 旋轉判定(未做)
			// 圖片長寬判斷
			// System.out.println("寬=>" + src.getWidth(null) + ":高=>" + src.getHeight(null));

			isWidthBig = src.getWidth(null) > src.getHeight(null);
			rateB = rateS = 0;

			if (isWidthBig) {
				rateB = rateWBig;
				rateS = rateWSmall;
			} else {
				rateB = rateHBig;
				rateS = rateHSmall;
			}

			// 實際將圖片的寬與高做等比例縮放
			int widthWBig = (int) (((double) src.getWidth(null)) / rateB);
			int widthHBig = (int) (((double) src.getHeight(null)) / rateB);

			int widthWSmall = (int) (((double) src.getWidth(null)) / rateS);
			int widthHSmall = (int) (((double) src.getHeight(null)) / rateS);

			//System.out.println("widthWBig=>" + widthWBig + " ; " + "widthHBig=>" + widthHBig);

			// new出BufferedImage物件=>BufferedImage(W,H,BufferedImage.TYPE_INT_RGB)(new出畫布的框架)
			bufferedImageBig = new BufferedImage(690, 690, BufferedImage.TYPE_INT_RGB);
			bufferedImageSmall = new BufferedImage(163, 163, BufferedImage.TYPE_INT_RGB);

			// 計算從何座標開始繪畫(要判斷圖片直式(改變X位置)or橫式(改變Y位置))
			//System.out.println("isWidthBig=>" + isWidthBig);
			
			if (isWidthBig) {
				Bdx = 0;
				Bdy = (690 - widthHBig) / 2;
				Sdx = 0;
				Sdy = (163 - widthHSmall) / 2;
			} else {
				Bdx = (690 - widthWBig) / 2;
				Bdy = 0;
				Sdx = (163 - widthWSmall) / 2;
				Sdy = 0;
			}

			// 做出Graphics2D物件,並用Graphics2D.getDeviceConfiguration().createCompatibleImage()劃出透明背景
			// 再重新將Graphics2D物件給做出來,並繪製圖片
			Graphics2D g2dB = bufferedImageBig.createGraphics();
			bufferedImageBig = g2dB.getDeviceConfiguration().createCompatibleImage(690, 690, Transparency.TRANSLUCENT);
			g2dB = bufferedImageBig.createGraphics();
			g2dB.drawImage(src.getScaledInstance(widthWBig, widthHBig, Image.SCALE_DEFAULT), Bdx, Bdy, null);

			Graphics2D g2dS = bufferedImageSmall.createGraphics();
			bufferedImageSmall = g2dS.getDeviceConfiguration().createCompatibleImage(163, 163,Transparency.TRANSLUCENT);
			g2dS = bufferedImageSmall.createGraphics();
			g2dS.drawImage(src.getScaledInstance(widthWSmall, widthHSmall, Image.SCALE_DEFAULT), Sdx, Sdy, null);

			// 設定名稱
			double random = (Math.random() * 10000000);
			String photonameOriginal = (LocalDate.now().toString() + id + photoNum + random + "-O" + "." + type);
			String photonameBig = (LocalDate.now().toString() + id + photoNum + random + "-B" + "." + type);
			String photonameSmall = (LocalDate.now().toString() + id + photoNum + random + "-S" + "." + type);

			// 將檔案名稱存入LinkedList<HashMap<String, String>> photoName;
			photoName = new HashMap<String, String>();
			photoName.put("Original", photonameOriginal);
			photoName.put("Big", photonameBig);
			photoName.put("Small", photonameSmall);

			// 設置輸出串流
			BufferedOutputStream Obout = new BufferedOutputStream(
					new FileOutputStream(new File(path + photonameOriginal)));

			BufferedOutputStream Bbout = new BufferedOutputStream(
					new FileOutputStream(new File(path + photonameBig)));

			BufferedOutputStream Sbout = new BufferedOutputStream(
					new FileOutputStream(new File(path + photonameSmall)));

			// 正式輸出,ImageIO.write(BufferedImage, "檔案格式", OutputStream);
			ImageIO.write(src, type, Obout);
			ImageIO.write(bufferedImageBig, "png", Bbout);
			ImageIO.write(bufferedImageSmall, "png", Sbout);

			// 關閉串流
			Obout.flush();
			Bbout.flush();
			Sbout.flush();
			Obout.close();
			Bbout.close();
			Sbout.close();

			//System.out.println("Save success");
		} catch (Exception e) {
			e.toString();
		}
		// 返回HashMap<String, String>photoName;
		return photoName;
	}
}
