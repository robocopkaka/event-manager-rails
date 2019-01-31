import React from 'react';
import classNames from 'classnames';

const CentersForm = ({
  name, address, capacity, description, handleChange, submit,
  errorMessages, fieldsValidity, handleImageUpload, image
}) => {
  const nameClasses = classNames('input', { 'is-danger': !fieldsValidity.name });
  const nameErrorMessage = classNames('help is-danger', { 'display-none': fieldsValidity.name });
  const addressClasses = classNames('input', { 'is-danger': !fieldsValidity.address });
  const addressErrorMessage = classNames('help is-danger', { 'display-none': fieldsValidity.address });
  const descriptionClasses = classNames('textarea', { 'is-danger': !fieldsValidity.description });
  const descriptionErrorMessage = classNames('help is-danger', { 'display-none': fieldsValidity.description });
  const capacityClasses = classNames('input', { 'is-danger': !fieldsValidity.capacity });
  const capacityErrorMessage = classNames('help is-danger', { 'display-none': fieldsValidity.capacity });
  return (
    <form className="centers-form">
      <div className="field">
        <label htmlFor="name" className="label">Name</label>
        <div className="has-icons-left control">
          <input
            type="text"
            name="name"
            value={name}
            className={nameClasses}
            onChange={handleChange}
          />
          <span className="icon is-small is-left">
            <i className="fa fa-user" />
          </span>
        </div>
        <p className={nameErrorMessage}>{errorMessages.name}</p>
      </div>
      <div className="field">
        <label htmlFor="address" className="label">Address</label>
        <div className="has-icons-left control">
          <input
            type="text"
            name="address"
            value={address}
            className={addressClasses}
            onChange={handleChange}
          />
          <span className="icon is-small is-left">
            <i className="fa fa-map-marker" />
          </span>
        </div>
        <p className={addressErrorMessage}>{errorMessages.address}</p>
      </div>
      <div className="field">
        <label htmlFor="capacity" className="label">Capacity</label>
        <div className="has-icons-left control">
          <input
            type="number"
            name="capacity"
            value={capacity}
            className={capacityClasses}
            onChange={handleChange}
          />
          <span className="icon is-small is-left">
            <i className="fa fa-users" />
          </span>
        </div>
        <p className={capacityErrorMessage}>{errorMessages.capacity}</p>
      </div>
      <div className="field">
        <label htmlFor="description" className="label">Description</label>
        <div className="has-icons-left control">
          <textarea
            name="description"
            value={description}
            className={descriptionClasses}
            onChange={handleChange}
          />
        </div>
        <p className={descriptionErrorMessage}>{errorMessages.description}</p>
      </div>
      <div className="file">
        <label className="file-label">
          <input className="file-input"
                 type="file"
                 name="resume"
                 onChange={handleImageUpload}
                 accept=".jpg,.png,.jpeg"
          />
          <span className="file-cta">
            <span className="file-icon">
              <i className="fa fa-upload" />
            </span>
            <span className="file-label">
              Choose a file…
            </span>
          </span>
          {image ? (
            <span className="file-name">
            {image.name ? image.name : image}
          </span>
          ) : ''}
        </label>
      </div>
      <div className="field">
        <p className="control">
          <button onClick={submit} className="button is-primary">Submit</button>
        </p>
      </div>
    </form>
  );
};
export default CentersForm;
