# Medical-imaging-carotid-artery-analysis
# demo影片
[![Everything Is AWESOME](https://user-images.githubusercontent.com/72666141/162747220-299e5514-49e9-4ab1-b872-84b635530584.png)](https://www.youtube.com/watch?v=T4urmRUW5Q4&list=PLDRej1fof0v3sUEld6KVRUjsh-aaUuiPk&index=1)

# 實現功能
1. 使用者介面在選擇檔案的功能中輸入超音波設備收集到的原始資料。
2. 將選取的原始資料進行資料與影像處理，得到頸動脈的收縮與擴展狀況，並使用訊號的方式，與原始資料進行同步的變化。
3. 將頸動脈的收縮與擴展狀況使用訊號展示後，並找出波峰與波谷，最後計算出硬化指標。


# GUI設計
![image](https://user-images.githubusercontent.com/72666141/162743555-f0b48eee-093c-4548-99e3-d3b41abbd915.png)
# 操作步驟
## Load Data 按鈕
* 步驟一：按下 Load Data 按鈕，讀取從超音波設備收集到的原始資料，其中實作出選擇檔案的功能，可以將選擇任意路徑，而不是單一路徑。

![image](https://user-images.githubusercontent.com/72666141/162743689-216c7223-df40-47f7-aeb8-7af93b481be6.png)

* 選取需要的原始資料後，會出現第一張原始資料的圖片在使用者介面上，此時也會出現提示視窗要標記出頸動脈的位置在使用者介面上，因為操作超音波
設備時的動作與力道不同，會導致頸動脈在位置與大小部分有所不同，希望可以使用不同資料，而不是單一資料。

![image](https://user-images.githubusercontent.com/72666141/162743937-779f3a6f-cbc1-4e24-ba00-aa8cc6f5d2b6.png)

* 標記的方式為使用滑鼠在圖片中分別按下左鍵兩次框出頸動脈位置，按下左鍵第一次代表長方形框左上的位置，按下左鍵第二次代表右下的位置，會出現
“ + ”。

![image](https://user-images.githubusercontent.com/72666141/162744008-fe630f61-5191-4342-a59a-807572a0e434.png)

* 框出頸動脈位置後(圖中加號位置)，因為要進行資料讀取與分割需要較長時間，所以加入進度讀取條，觀察目前程式進行狀況，最後顯示提示窗告知處理
完成。

![image](https://user-images.githubusercontent.com/72666141/162744102-aa387c81-d078-41b7-b64f-cf9f42963d49.png)

* 讀取資料完成

![image](https://user-images.githubusercontent.com/72666141/162744234-0e10125d-4472-403d-82a4-1dde829af9ca.png)

## Image Processing 按鈕
* 步驟二：按下 Image Processing 按鈕，對前面分割的頸動脈部分進行影像處理，因為處理時間較長，所以加入進度條，展示目前程式進行狀況。

![image](https://user-images.githubusercontent.com/72666141/162744474-1f514411-46f9-4755-93f3-7cde23134671.png)

* 影像處理部分結束後會出現提示框，告知影像處理已經完成。

![image](https://user-images.githubusercontent.com/72666141/162744510-b08f06a9-8215-435a-87bc-35d29e003824.png)

## Show 按鈕
* 步驟三：按下 Show 按鈕，此時會出現提示視窗，在右邊出現的頸動脈圖片中，畫一個圓形在頸動脈裡面作為標記。

![image](https://user-images.githubusercontent.com/72666141/162744781-d01fd414-d1bf-4cba-b012-437532316028.png)

![image](https://user-images.githubusercontent.com/72666141/162744798-1a0ba696-a1a4-4c29-b87e-2dfbf3f72d83.png)

* 輸出結果左邊顯示從超音波設備收集的原始資料，右邊顯示的訊號為隨著頸動脈的收縮與擴張時的同步狀況，計算完波形圖後，會自動找出波形圖中波峰與波谷並使用紅色星星與綠色圈圈作為標記。

![image](https://user-images.githubusercontent.com/72666141/162744850-3c50c14b-6153-44c3-93e1-0aef4576e2d5.png)

![image](https://user-images.githubusercontent.com/72666141/162744860-c86dcfe9-e25a-4bfb-8a14-76bf2fc8134d.png)

* 得到波峰與波谷後，會跳出輸入視窗，輸入收縮壓與舒張壓(使用血壓計測量的結果) 。

![image](https://user-images.githubusercontent.com/72666141/162744930-597ebb27-23c0-4e30-8f23-76e8cd57e358.png)

* 最後會將計算出的波峰波谷平均值與收縮壓與舒張壓進行計算出硬化指標數值。

![image](https://user-images.githubusercontent.com/72666141/162744996-1022c8a2-bb86-49a4-8b58-8f918ed55428.png)

* 最後當計算完結果後，可以按下Quit按鈕，會顯示提示視窗詢問是否要離開程式，只有按下yes才會結束程式。

![image](https://user-images.githubusercontent.com/72666141/162745052-3045bcb5-110e-458b-97b8-9b7e789fc7fd.png)



