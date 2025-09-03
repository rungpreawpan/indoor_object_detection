# Indoor Object Detection

Indoor Object Detection is an assistive application for visually impaired users.  
It provides **Object Detection**, **Obstacle Detection (Depth Estimation)**, and **OCR (Optical Character Recognition)** through a system architecture that connects:

**Flutter (mobile app) ↔ Express (Node.js API Gateway) ↔ Flask (Python ML backend)**

---

## 🔗 System Architecture

```
Flutter (Mobile App)
   │
   ├──> Express Server (Node.js)
   │        - API Gateway
   │
   └──> Flask Server (Python)
            - Object Detection (YOLOv8)
            - Obstacle Detection (MiDaS Depth Estimation)
            - OCR (Tesseract)
```

---

## ✨ Features

- **Object Detection** – Detect indoor objects such as doors, chairs, stairs, elevators, etc.  
- **Obstacle Detection** – Estimate the distance of obstacles using MiDaS depth models  
- **OCR** – Read text from signs or bulletin boards and convert it to speech  
- **Voice Command** – Control the app using speech (supports English & Thai)  
- **API Gateway** – Express.js as the middleware between Flutter and Flask  

---

## ⚙️ Installation

### 1. Clone repository
```bash
git clone https://github.com/rungpreawpan/indoor_object_detection.git
git clone https://github.com/rungpreawpan/indoor_object_detection_model.git
git clone https://github.com/rungpreawpan/indoor_object_detection_server.git
```

### 2. Setup Flask server (ML backend)
```bash
python main.py
```
Flask will run on: `http://localhost:5003`

### 3. Setup Express server (API gateway)
```bash
npm i
npm run dev
```
Express will run on: `http://localhost:3000`

### 4. Setup Flutter mobile app
```bash
flutter pub get
flutter run
```
> Make sure the Flutter app points to your **Express API URL** (`http://localhost:3000` or server IP).

---

## 📂 Project Structure

```
indoor_object_detection/
│
├── mobile-app/          # Flutter application (frontend)
│
├── server-express/      # Node.js Express (API Gateway)
│   ├── routes/
│   ├── controllers/
│   └── models/
│
├── server-flask/        # Python Flask (ML models)
│   ├── object_detection/
│   ├── obstacle_detection/
│   └── ocr/
│
└── README.md
```

---

## 📡 API Endpoints

All requests are sent to **Express**, which forwards them to Flask.

### 1. Object Detection
```http
POST /api/detect
Content-Type: multipart/form-data
Body:
  - image: <image_file>
```
**Response**
```json
{
    "objects": {
        "boxes": [
            {
                "label": "laptop",
                "confidence": 0.964,
                "x1": 36.03303527832031,
                "y1": 9.935333251953125,
                "x2": 530.2341918945312,
                "y2": 366.5954895019531
            },
            {
                "label": "keyboard",
                "confidence": 0.891,
                "x1": 1.1773681640625,
                "y1": 348.64007568359375,
                "x2": 627.6668701171875,
                "y2": 590.3521728515625
            },
            {
                "label": "laptop",
                "confidence": 0.572,
                "x1": 563.5152587890625,
                "y1": 59.942230224609375,
                "x2": 639.748779296875,
                "y2": 225.96768188476562
            },
            {
                "label": "mouse",
                "confidence": 0.56,
                "x1": 548.3927001953125,
                "y1": 320.8844299316406,
                "x2": 639.7945556640625,
                "y2": 429.3517150878906
            }
        ],
        "image_width": 640,
        "image_height": 640
    }
}
```

### 2. Obstacle Detection (Depth)
```http
POST /api/depth
Content-Type: multipart/form-data
Body:
  - image: <image_file>
```
**Response**
```json
{
    "obstacle": [
        {
            "label": "bulletin board",
            "confidence": 0.382,
            "x1": 94,
            "y1": 454,
            "x2": 128,
            "y2": 483,
            "median_depth": 0.609,
            "close_depth": 0.148,
            "direction": "ซ้าย",
            "priority": 0.622,
            "message": "มีbulletin board ขวางทางด้านซ้าย"
        },
        {
            "label": "bulletin board",
            "confidence": 0.322,
            "x1": 350,
            "y1": 497,
            "x2": 396,
            "y2": 533,
            "median_depth": 0.489,
            "close_depth": 0.149,
            "direction": "หน้า",
            "priority": 0.745,
            "message": "มีbulletin board ขวางทางด้านหน้า"
        }
    ],
    "image_width": 640,
    "image_height": 640
}
```

### 3. OCR
```http
POST /api/ocr
Content-Type: multipart/form-data
Body:
  - image: <image_file>
```
**Response**
```json
{
    "text": "Lorem Ipsum\n\nMeaning\n\nLorem Ipsum is essentially the typeset and printing industry's dummy text.\nSince an unidentified printer jumbled a galley of type to create a type specimen\nbook in the 1500s, Lorem Ipsum has been the industry standard sham text.\n\nIt is virtually intact, having withstood not just five centuries but also the\ntransition to electronic typesetting.\n\nThe introduction of Letraset sheets with sections from Lorem Ipsum in the\n1960s and, more recently, the inclusion of Lorem Ipsum versions in desktop\npublishing programs like Aldus PageMaker contributed to its popularization.\n",
    "lang": "eng"
}
```

---

## 📱 Example Flow

1. User opens the camera → Flutter captures an image  
2. Flutter sends the image to **Express** 
3. Express forwards the request to **Flask**  
4. Flask runs ML inference and returns results → Express → Flutter  
5. Flutter converts the response into audio feedback  

---

## 🛠️ Tech Stack

- **Mobile:** Flutter (Dart)  
- **API Gateway:** Express.js (Node.js)  
- **ML Backend:** Flask (Python)  
  - YOLOv8 → Object Detection  
  - MiDaS → Depth Estimation  
  - Tesseract → OCR  
- **Database:** SQLite (via Express)  
