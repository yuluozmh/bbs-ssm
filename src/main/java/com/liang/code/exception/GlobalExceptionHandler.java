package com.liang.code.exception;

import com.liang.code.ReturnT;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;

/**
 * 全局异常处理器
 *
 * @author maliang
 * @create 2020-07-16 10:23
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    private Logger logger = LoggerFactory.getLogger(getClass());

    private static final int DUPLICATE_KEY_CODE = 1001;
    private static final int PARAM_FAIL_CODE = 1002;
    private static final int VALIDATION_CODE = 1003;

    /**
     * 方法参数校验（@Validated + @NotBlank）
     *
     * @param e
     * @return
     */
    @ExceptionHandler(BindException.class)
    public ReturnT<?> handleMethodArgumentNotValidException(BindException e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(PARAM_FAIL_CODE, e.getBindingResult().getFieldError().getDefaultMessage());
    }

    /**
     * ValidationException
     */
    @ExceptionHandler(ValidationException.class)
    public ReturnT<?> handleValidationException(ValidationException e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(VALIDATION_CODE, e.getCause().getMessage());
    }

    /**
     * ConstraintViolationException
     */
    @ExceptionHandler(ConstraintViolationException.class)
    public ReturnT<?> handleConstraintViolationException(ConstraintViolationException e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(PARAM_FAIL_CODE, e.getMessage());
    }

    /**
     * 路径不存在
     *
     * @param e
     * @return
     */
    @ExceptionHandler(NoHandlerFoundException.class)
    public ReturnT<?> handlerNoFoundException(Exception e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(HttpStatus.NOT_FOUND, "路径不存在，请检查路径是否正确");
    }

    /**
     * 数据重复
     *
     * @param e
     * @return
     */
    @ExceptionHandler(DuplicateKeyException.class)
    public ReturnT<?> handleDuplicateKeyException(DuplicateKeyException e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(DUPLICATE_KEY_CODE, "数据重复，请检查后提交");
    }

    /**
     * 其它异常
     *
     * @param e
     * @return
     */
    @ExceptionHandler(Exception.class)
    public ReturnT<?> handleException(Exception e) {
        logger.error(e.getMessage(), e);
        return new ReturnT<>(HttpStatus.INTERNAL_SERVER_ERROR, "系统繁忙,请稍后再试");
    }

    /**
     * 自定义异常
     *
     * @param e
     * @return
     */
//    @ExceptionHandler(BizException.class)
//    public RspDTO handleRRException(BizException e) {
//        logger.error(e.getMessage(), e);
//        return new RspDTO(e.getCode(), e.getMessage());
//    }
}
