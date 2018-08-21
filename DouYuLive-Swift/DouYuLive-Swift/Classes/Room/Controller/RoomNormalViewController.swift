//
//  RoomNormalViewController.swift
//  DouYuLive-Swift
//
//  Created by lidong on 2018/8/16.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit
import AVFoundation

class RoomNormalViewController: UIViewController {

    private lazy var startCaptureBtn: UIButton = {
        let startCaptureBtn = UIButton()
        startCaptureBtn.frame = CGRect(x: 20, y: 100, width: 120, height: 50)
        startCaptureBtn.setTitle("开始采集", for: .normal)
        startCaptureBtn.setTitleColor(UIColor.black, for: .normal)
        startCaptureBtn.addTarget(self, action: #selector(startCaptureBtnPress), for: .touchUpInside)
        return startCaptureBtn
    }()
    private lazy var stopCaptureBtn: UIButton = {
        let stopCaptureBtn = UIButton()
        stopCaptureBtn.frame = CGRect(x: 200, y: 100, width: 120, height: 50)
        stopCaptureBtn.setTitle("结束采集", for: .normal)
        stopCaptureBtn.setTitleColor(UIColor.black, for: .normal)
        stopCaptureBtn.addTarget(self, action: #selector(stopCaptureBtnPress), for: .touchUpInside)
        return stopCaptureBtn
    }()
    private lazy var switchCaptureBtn: UIButton = {
        let switchCaptureBtn = UIButton()
        switchCaptureBtn.frame = CGRect(x: 20, y: 300, width: 120, height: 50)
        switchCaptureBtn.setTitle("切换摄像头", for: .normal)
        switchCaptureBtn.setTitleColor(UIColor.black, for: .normal)
        switchCaptureBtn.addTarget(self, action: #selector(changeCapturePress), for: .touchUpInside)
        return switchCaptureBtn
    }()
    
    private lazy var videoQueue = DispatchQueue.global()
    
    private lazy var audioQueue = DispatchQueue.global()
    
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    private var videoOutput: AVCaptureVideoDataOutput?
    
    private var videoInput: AVCaptureDeviceInput?
    
    private var movieFileOutput: AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(self.startCaptureBtn)
        self.view.addSubview(self.stopCaptureBtn)
        self.view.addSubview(self.switchCaptureBtn)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
//        //保持滑动退出手势
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;
//    
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
}

extension RoomNormalViewController {
    
    @objc private func startCaptureBtnPress() {
        
        self.setupVideo()
        
        self.setupAudio()
        
        //添加写入文件
        self.session.addOutput(self.movieFileOutput)
        
        //设置写入稳定性
        let connection = self.movieFileOutput.connection(with: .video)
        connection?.preferredVideoStabilizationMode = .auto
        
        //设置预言图层（可选）
        self.previewLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(self.previewLayer, at: 0)
        
        //开始采集
        self.session.startRunning()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abcd.mp4"
        let url = URL(fileURLWithPath: path)
        self.movieFileOutput.startRecording(to: url, recordingDelegate: self)
        
    }
    
    @objc private func stopCaptureBtnPress() {
        
        self.movieFileOutput.stopRecording()
        
        self.session.stopRunning()
        
        self.previewLayer.removeFromSuperlayer()
        
    }
    
    @objc private func changeCapturePress() {
        
        guard var position = self.videoInput?.device.position else { return }
        
        position = position == .front ? .back : .front
        
        let devices = AVCaptureDevice.devices(for: .video)
        
        guard let device = devices.filter({$0.position == position}).first else { return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        self.session.beginConfiguration()
        self.session.removeInput(self.videoInput!)
        self.session.addInput(videoInput)
        self.session.commitConfiguration()
        self.videoInput = videoInput
        
    }
    
    private func setupVideo() {
        
        //设置捕捉会话设置输入源
        //获取摄像头
        let devices = AVCaptureDevice.devices(for: .video)
        
        let device = devices.filter { (device: AVCaptureDevice) -> Bool in
            return device.position == .front
            }.first
        
        //通过device创建Input对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device!) else {return}
        
        self.videoInput = videoInput
        
        self.session.addInput(videoInput)
        
        //设置输出源
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: self.videoQueue)
        
        self.session.addOutput(videoOutput)
        
        //获取AVCaptureVideoDataOutput
        self.videoOutput = videoOutput
        
    }
    
    private func setupAudio() {
        
        //设置音频的输入（话筒）
        guard let device = AVCaptureDevice.default(for: .audio) else {return}
        
        //创建input
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else {return}
        
        self.session.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        
        audioOutput.setSampleBufferDelegate(self, queue: self.audioQueue)
        
        self.session.addOutput(audioOutput)
        
    }
    
}

extension RoomNormalViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if(connection == self.videoOutput?.connection(with: .video)) {
            
            print("采集到的视频数据")
            
        }else{
            
            print("采集到的音频数据")
            
        }
        
    }
    
}

extension RoomNormalViewController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("开始写入文件")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("结束写入文件")
    }
    
}

