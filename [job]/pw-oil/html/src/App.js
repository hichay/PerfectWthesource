import logo from './logo.svg';
import React, { useState, useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import "./css/App.scss"
import './fontawesome-pro-5.15.3-web/css/brands.css'
import './fontawesome-pro-5.15.3-web/css/solid.css'
import './fontawesome-pro-5.15.3-web/css/fontawesome.css'
import './fontawesome-pro-5.15.3-web/css/duotone.css'
import './fontawesome-pro-5.15.3-web/css/regular.css'
import { CircularProgressbar, buildStyles  } from 'react-circular-progressbar';
import 'react-circular-progressbar/dist/styles.css';
import drill from "./assets/drill.png"
function lr(type, url, data, cb){
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
          if (cb){
              cb(JSON.parse(xhr.response));
          }
      }
  }
  
  xhr.open(type, url, true);
  xhr.send(JSON.stringify(data));
}


function App(props) {
  const [show, setShow] = useState(false);
  const [curProduct, setCurProduct] = useState("gasoline");
  const [data, setData] = useState(null)
  const [skill, setSkill] = useState(null)
  const [timeOnline, setTimeOnline] = useState(0)
  useEffect(() => {
    function EventListener(e){
      if(e.data.event === "setShow"){
        setShow(e.data.data)
      }else if(e.data.event === 'setData'){
        setData(e.data.data)
      }else if(e.data.event === 'setSkill'){
        setSkill(e.data.data)
      }else if(e.data.event === 'setTimeOnline'){
        setTimeOnline(e.data.data)
      }
    }

    function Keypress(e){
      if (e.key === "Escape"){
          lr("POST", "https://pw-oil/Close")
      }
    }

    window.addEventListener("message", EventListener)
    window.addEventListener("keyup", Keypress)
    return () => {
        /* clearInterval(t) */
        window.removeEventListener("message", EventListener)
        window.removeEventListener("keyup", Keypress)
    }
  }, [show])
  
  return (
    show && <div className="App">
      <Owner {...data}/>
      <CollectProfits  {...data}/>
      <Description  {...data}/>
      <Empty top="23vh" />
      <Status  {...data}/>
      <Empty top="37vh" />
      <Workers  {...data}/>
      <SkillLevel  {...data}/>
      <After4Hours/>
      <Title/>
      <Action curProduct={curProduct} {...skill} {...{timeOnline}}/>
      <Products curProduct={curProduct} setCurProduct={setCurProduct}/>
    </div>
  );
}

export default App;

function Owner(props){

  return(
    <div className='owner'>
      <div className='content'>
        <div className='text-trans'>Chủ sở hữu</div>
        <div className='text-white' style={{fontSize: "1vw"}}>{props.owner ? props.owner : "Không có" }</div>
      </div>
      <div className='icon'>
        <i className="fas fa-fist-raised"></i>
      </div>
    </div>
  )
}

function CollectProfits(props){
  return (
    <div className='collectProfits'>
      <div className='btn'>Thu lợi nhuận</div>
    </div>
  )
}

function Description(){
  return(
    <div className='description'>
      <div>Băng nhóm sở hữu giếng dầu</div>
      <div>Sẽ nhận được thu nhập từ những công nhân làm việc ở đây</div>
    </div>
  )
}

function Empty(props){
  return(
    <div className='empty' style={{top:props.top}}>
      
    </div>
  )
}

function Status({Quantity}){
  function RenderStatusCircle(){
    if(Quantity > 50){
      return <i className="fas fa-circle" style={{color:"#B1E04A", margin:".3vw"}}></i>
    }else if(Quantity <= 50 && Quantity > 0){
      return <i className="fas fa-circle" style={{color:"#ffbe0b", margin:".3vw"}}></i>
    }else{
      return <i className="fas fa-circle" style={{color:"#ff4242", margin:".3vw"}}></i>
    }
  }

  return(
    <div className='status'>
      <div className='text-trans'>Tình trạng</div>
      <div style={{display:"flex", fontSize:"1vw", alignItems:"center"}}>
        {RenderStatusCircle()}
        <div style={{margin:".3vw", textAlign:"right"}}>{Quantity}/1000</div>
      </div>
    </div>
  )
}

function Workers({Workers}){
  return(
    <div className='workers'>
      {Workers ? Workers.length : 0} Công nhân
      
    </div>
    
  )
}

function SkillLevel({skill}){
  return( skill !== undefined &&
    <>
      <div className='skill-level'>
        <div className='data'>
          <div className='content' style={{textAlign:"right", fontSize:"1vw"}}>
            <div>Cấp độ</div>
            <div>Công việc</div>
          </div>
          <div style={{ width: "4vw", height: "4vw"}}>
            <CircularProgressbar 
                value={ skill.exp / skill.max_exp * 100} 
                strokeWidth={4}
                text={skill.level}
                styles={buildStyles({
                    // Whether to use rounded or flat corners on the ends - can use 'butt' or 'round'
                    strokeLinecap: 'butt',
                
                    // Text size
                    textSize: '1vw',
                
                    // How long animation takes to go from one percentage to another, in seconds
                    pathTransitionDuration: 0.5,
                
                    // Can specify path transition in more detail, or remove it entirely
                    // pathTransition: 'none',
                
                    // Colors
                    pathColor: `rgba(255, 243, 0, 255)`,
                    textColor: 'rgba(255, 243, 0, 255)',
                    trailColor: 'rgba(245, 245, 245, 0.226)',
                    backgroundColor: 'transparent',
                })}
            />
          </div>
        </div>
        <div className='skill-desc text-trans'>
          <p>nếu bạn đạt level 2:</p>
          <p>tốc độ sản xuất sẽ được đẩy nhanh</p>
          <p>nếu bạn đạt level 3:</p>
          <p>có cơ hội nhận 1 lúc 2 sản phẩm</p>
        </div>
      </div>
      
    </>
  )
}

function After4Hours(){
  return(
    <div className='after-4-hours'>
      <div style={{ textAlign:"right"}}>
        <div style={{fontSize: "1vw"}}>Sau 4 giờ chơi</div>
        <div style={{fontFamily: "OpenSansCondensed-Light"}}>Tốc độ đào sẽ tăng lên 20%</div>
      </div>
      <div className='icon text-trans' style={{ fontSize: "2vw"}}>
        <i className="fas fa-user-clock"></i>
      </div>
    </div>
  )
}

function Title(){
  return(
    <div className='title'>
      Giàn khoan <br/> dầu
    </div>
  )
}

function Action({curProduct, oil, timeOnline}){
  const [drill1, setDrill1] = useState(0)
  const [drill2, setDrill2] = useState(0)
  const [drill3, setDrill3] = useState(0)
  const [drill4, setDrill4] = useState(0)
  const intervalRef = useRef(null)

  useEffect(() => {
    
  
    return () => {
      stopCount()
    }
  }, [])
  

  const startCount = (drill) => {
    for(var i = 1; i<=4; i++){
      if (i != drill){
        stopCount(i)
      }
    }
    let timeInterval = 40;
    if (oil != null && oil.level === 2){
      timeInterval = 30
    }else if(oil != null && oil.level >= 3){
      timeInterval = 25
    }
    if(timeOnline !== undefined && timeOnline >= 14400){
      timeInterval = timeInterval - 8
    }
    if (intervalRef.current) return;
    switch (drill){
      case 1:
      intervalRef.current = setInterval(() => {
        setDrill1((prev) => {
          if(prev >= 100){
            clearInterval(intervalRef.current);
            intervalRef.current = null;
          }
          return prev + 1
        });
        
      },  timeInterval);
      
      break;
      case 2:
      intervalRef.current = setInterval(() => {
        setDrill2((prev) => {
          if(prev >= 100){
            clearInterval(intervalRef.current);
            intervalRef.current = null;
          }
          return prev + 1
        });
      }, timeInterval);
      break;
      case 3:
      intervalRef.current = setInterval(() => {
        setDrill3((prev) => {
          if(prev >= 100){
            clearInterval(intervalRef.current);
            intervalRef.current = null;
          }
          return prev + 1
        });
      }, timeInterval);
      break;
      case 4:
      intervalRef.current = setInterval(() => {
        setDrill4((prev) => {
          if(prev >= 100){
            clearInterval(intervalRef.current);
            intervalRef.current = null;
          }
          return prev + 1
        });
      }, timeInterval);
      break;
      default:
    }
  }

  const stopCount = (drill)=>{
    if(intervalRef.current){
      clearInterval(intervalRef.current);
      intervalRef.current = null;
      switch (drill){
        case 1:
          setDrill1(0);
          break;
        case 2:
          setDrill2(0);
          break;
        case 3:
          setDrill3(0);
          break;
        case 4:
          setDrill4(0);
          break;
        default:
          setDrill1(0);
          setDrill2(0);
          setDrill3(0);
          setDrill4(0);
      }
    }
  }
  if(drill1 >= 101 && drill2 >= 101 && drill3 >= 101 && drill4 >= 101){
    setDrill1(0);
    setDrill2(0);
    setDrill3(0);
    setDrill4(0);
    lr('POST', 'https://pw-oil/Drill', {product: curProduct})
  }

  return(
    <div className='action'>
      <div style={{fontSize: "1vw"}}>
        Khoan đường đến các <br/>tháp dầu
      </div>
      <div style={{display:"flex", alignItems:"center"}}>
        <div className="text-trans" style={{fontSize: "1vw", fontFamily:"OpenSansCondensed-Light"}}>
          Giữ chuột trái<br/> để khoan
        </div>
        <div style={{height: "20vh", display:"flex"}}>
          <div className='drill'>
            <img src={drill} style={{opacity: drill1 >= 100 ? "1" : "0.226"}}></img>
            <div style={{ width: "3vw", height: "3vw", bottom:"-1.9vh"}} onMouseDown={()=>{startCount(1)}} onMouseUp={()=>{stopCount(1)}} onMouseLeave={()=>{stopCount(1)}}>
              <CircularProgressbar 
                  value={ drill1} 
                  strokeWidth={20}
                  styles={buildStyles({
                      // Whether to use rounded or flat corners on the ends - can use 'butt' or 'round'
                      strokeLinecap: 'butt',
                  
                      // Text size
                      textSize: '1vw',
                  
                      // How long animation takes to go from one percentage to another, in seconds
                      pathTransitionDuration: 0,
                  
                      // Can specify path transition in more detail, or remove it entirely
                      // pathTransition: 'none',
                  
                      // Colors
                      pathColor: `white`,
                      textColor: 'rgba(255, 243, 0, 255)',
                      trailColor: 'rgba(245, 245, 245, 0.226)',
                      backgroundColor: 'transparent',
                  })}
              />
            </div>
          </div>
          <div className='drill'>
            <img src={drill} style={{opacity: drill2 >= 100 ? "1" : "0.226"}}></img>
            <div style={{ width: "3vw", height: "3vw", bottom:"-1.9vh"}} onMouseDown={()=>{startCount(2)}} onMouseUp={()=>{stopCount(2)}} onMouseLeave={()=>{stopCount(2)}}>
              <CircularProgressbar 
                  value={ drill2} 
                  strokeWidth={20}
                  styles={buildStyles({
                      // Whether to use rounded or flat corners on the ends - can use 'butt' or 'round'
                      strokeLinecap: 'butt',
                  
                      // Text size
                      textSize: '1vw',
                  
                      // How long animation takes to go from one percentage to another, in seconds
                      pathTransitionDuration: 0,
                  
                      // Can specify path transition in more detail, or remove it entirely
                      // pathTransition: 'none',
                  
                      // Colors
                      pathColor: `white`,
                      textColor: 'rgba(255, 243, 0, 255)',
                      trailColor: 'rgba(245, 245, 245, 0.226)',
                      backgroundColor: 'transparent',
                  })}
              />
            </div>
          </div>
          <div className='drill'>
            <img src={drill} style={{opacity: drill3 >= 100 ? "1" : "0.226"}}></img>
            <div style={{ width: "3vw", height: "3vw", bottom:"-1.9vh"}} onMouseDown={()=>{startCount(3)}} onMouseUp={()=>{stopCount(3)}} onMouseLeave={()=>{stopCount(3)}}>
              <CircularProgressbar 
                  value={ drill3} 
                  strokeWidth={20}
                  styles={buildStyles({
                      // Whether to use rounded or flat corners on the ends - can use 'butt' or 'round'
                      strokeLinecap: 'butt',
                  
                      // Text size
                      textSize: '1vw',
                  
                      // How long animation takes to go from one percentage to another, in seconds
                      pathTransitionDuration: 0,
                  
                      // Can specify path transition in more detail, or remove it entirely
                      // pathTransition: 'none',
                  
                      // Colors
                      pathColor: `white`,
                      textColor: 'rgba(255, 243, 0, 255)',
                      trailColor: 'rgba(245, 245, 245, 0.226)',
                      backgroundColor: 'transparent',
                  })}
              />
            </div>
          </div>
          <div className='drill'>
            <img src={drill} style={{opacity: drill4 >= 100 ? "1" : "0.226"}}></img>
            <div style={{ width: "3vw", height: "3vw", bottom:"-1.9vh"}} onMouseDown={()=>{startCount(4)}} onMouseUp={()=>{stopCount(4)}} onMouseLeave={()=>{stopCount(4)}}>
              <CircularProgressbar 
                  value={ drill4} 
                  strokeWidth={20}
                  styles={buildStyles({
                      // Whether to use rounded or flat corners on the ends - can use 'butt' or 'round'
                      strokeLinecap: 'butt',
                  
                      // Text size
                      textSize: '1vw',
                  
                      // How long animation takes to go from one percentage to another, in seconds
                      pathTransitionDuration: 0,
                  
                      // Can specify path transition in more detail, or remove it entirely
                      // pathTransition: 'none',
                  
                      // Colors
                      pathColor: `white`,
                      textColor: 'rgba(255, 243, 0, 255)',
                      trailColor: 'rgba(245, 245, 245, 0.226)',
                      backgroundColor: 'transparent',
                  })}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

function Products({curProduct, setCurProduct}){
  function RenderClass(product){
    if (product === curProduct){
      return 'product active'
    }else{
      return 'product'
    }
  }
  return(
    <div className='products'>
      <div className={RenderClass('gasoline')} onClick={()=>{setCurProduct('gasoline')}}>
        <i className="fas fa-gas-pump"></i>
        <p>Xăng thô</p>
      </div>
      {/* <div className={RenderClass('solar')} onClick={()=>{setCurProduct('solar')}}>
        <i className="fas fa-gas-pump"></i>
        <p>solar</p>
      </div>
      <div className={RenderClass('kerosene')} onClick={()=>{setCurProduct('kerosene')}}>
        <i className="fas fa-gas-pump"></i>
        <p>kerosene</p>
      </div> */}
    </div>
  )
}